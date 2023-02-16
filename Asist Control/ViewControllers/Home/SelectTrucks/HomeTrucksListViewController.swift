//
//  AllTrucksListViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/8/22.
//

import UIKit

class HomeTrucksListViewController: HomeViewController, HomeControllerDelegate {
  
  private lazy var controller = HomeController(delegate: self)
  
  private let listViewTitle: UILabel = {
    let label = UILabel()
    label.font = .h3
    label.textColor = .primaryLabel
    label.numberOfLines = 0
    label.textAlignment = .center
    label.enableAutolayout()
    
    return label
  }()
  
  private let scrollView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.enableAutolayout()
    
    return scroll
  }()
  
  private let contentView: UIView = {
    let view = UIView()
    view.enableAutolayout()
    
    return view
  }()
    
  private let listView: UITableView = {
    let tv = UITableView()
    tv.backgroundColor = .background
    tv.isScrollEnabled = false
    tv.register(SelectTruckTableViewCell.self, forCellReuseIdentifier: SelectTruckTableViewCell.identifier)
    tv.enableAutolayout()
    
    return tv
  }()
    
  private let continueButton: ACButton = {
    let button = ACButton()
    button.title = "Continuar".uppercased()
    button.enableAutolayout()
    
    return button
  }()
    
  var trucks: [Truck] = []
  var selectedTrucks: [Truck] = []
  
  var sections = BPSCompany.allCases
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSubviews()
    setupConstraints()
    setupActions()

    listView.delegate = self
    listView.dataSource = self
    
    controller.getAllTrucksAndLoadThemIntoApp()
  }
  
  private func setupSubviews() {
      
    title = "Seleccionar camiones"
    
    listView.backgroundColor = .background
    view.addSubview(listViewTitle)
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    
    contentView.addSubview(listView)
    contentView.addSubview(continueButton)
    continueButton.makeRoundedCorners()
    
    setupTitleTextWithDate()
  }
    
  var tableViewHeight: NSLayoutConstraint?
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      listViewTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      listViewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      listViewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
      scrollView.topAnchor.constraint(equalTo: listViewTitle.bottomAnchor, constant: 10),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
      
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
      
      listView.topAnchor.constraint(equalTo: contentView.topAnchor),
      listView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      listView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      
      continueButton.topAnchor.constraint(equalTo: listView.bottomAnchor, constant: 10),
      continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      continueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
      continueButton.heightAnchor.constraint(equalToConstant: 56)
    ])
    tableViewHeight = contentView.heightAnchor.constraint(equalToConstant: 0)
    tableViewHeight?.isActive = true
  }

  private func setupActions() {
    continueButton.addTarget(self, action: #selector(continueButtonWasTapped), for: .touchUpInside)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
      
    let cellHeightsTotal = CGFloat(50 * trucks.count)
    let sectionsHeightTotal = CGFloat(50 * 3)
    tableViewHeight?.constant = (cellHeightsTotal + sectionsHeightTotal + continueButton.bounds.height + 55)
  }
  
  private func setupTitleTextWithDate() {
    listViewTitle.text = Current.Today().stringDate
  }
  
  private func selectOrDeselectTruck(_ truck: Truck) {
    truck.isSelected.toggle()
    if selectedTrucks.contains(where: { $0.id == truck.id }) {
      selectedTrucks.removeAll { $0.id == truck.id }
    } else {
      selectedTrucks.append(truck)
    }
    listView.reloadData()
  }
  
  func dataLoaded() {
    trucks = Current.shared.trucks
    listView.reloadData()
    view.layoutIfNeeded()
  }

  @objc private func continueButtonWasTapped() {
    let vc = SelectedTrucksViewController()
    vc.configure(with: selectedTrucks)
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension HomeTrucksListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].rawValue
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let company = sections[section]
    switch company {
    case .rustic:
      return Current.shared.rusticTrucks.count
    case .sadel:
      return Current.shared.sadelTrucks.count
    case .delsa:
      return Current.shared.delsaTrucks.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SelectTruckTableViewCell.identifier, for: indexPath)
    
    guard let cell = cell as? SelectTruckTableViewCell, trucks.count > 0 else { return cell }
    
    let truck = trucks[indexPath.row]
    cell.configure(with: truck)

    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let truck = trucks[indexPath.row]
    selectOrDeselectTruck(truck)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(50)
  }
}

extension HomeTrucksListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    // TODO: Swipe
    return nil
  }
}
