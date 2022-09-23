//
//  SelectedTrucksViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 9/17/22.
//

import UIKit

class SelectedTrucksViewController: UIViewController {

  private var selectedTrucks: [Truck] = []
  var sections = BPSCompany.allCases

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
    tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tv.enableAutolayout()
    
    return tv
  }()
  
  private let continueButton: ACButton = {
    let button = ACButton()
    button.title = "Continuar".uppercased()
    button.enableAutolayout()
    
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .background

    setupSubviews()
    setupConstraints()
    setupTitleTextWithDate()

    listView.delegate = self
    listView.dataSource = self
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let cellHeightsTotal = CGFloat(50 * selectedTrucks.count)
    let sectionsHeightTotal = CGFloat(50 * 3)
    tableViewHeight?.constant = (cellHeightsTotal + sectionsHeightTotal + continueButton.bounds.height + 55)
  }

  private func setupSubviews() {
    
    title = "Camiones Seleccionados"
    
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

  private func setupTitleTextWithDate() {
    listViewTitle.text = Current.Today().stringDate
  }

  func configure(with trucks: [Truck]) {
    selectedTrucks = trucks
  }
}

extension SelectedTrucksViewController: UITableViewDataSource {
  
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
      let rusticTrucks = selectedTrucks.filter({ $0.companyBPS == .rustic })
      return rusticTrucks.count
    case .sadel:
      let sadelTruck = selectedTrucks.filter({ $0.companyBPS == .sadel })
      return sadelTruck.count
    case .delsa:
      let delsaTrucks = selectedTrucks.filter({ $0.companyBPS == .delsa })
      return delsaTrucks.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    guard selectedTrucks.count > 0 else { return cell }
    
    let truck = selectedTrucks[0]
    cell.textLabel?.text = truck.id
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(50)
  }
}

extension SelectedTrucksViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let truck = selectedTrucks[indexPath.row]
    print(truck.driver?.firstName)
  }

  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    // TODO: Swipe
    let action = UIContextualAction(style: .normal, title: "Deselect") { action, view, completion in
      let index = indexPath.row
      self.selectedTrucks.remove(at: index)
      self.listView.reloadData()
    }
    action.backgroundColor = .red
    let swipe = UISwipeActionsConfiguration(actions: [action])
    return swipe
  }

  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .normal, title: "Edit") { action, view, completion in
      let truck = self.selectedTrucks[indexPath.row]
      print("\(truck.id) + \(truck.driverId)")
      // TODO: Create Edit Truck View
      // This view should let the user update the driver and the assistants.
    }
    let swipe = UISwipeActionsConfiguration(actions: [action])
    swipe.performsFirstActionWithFullSwipe = false
    return swipe
  }
}
