//
//  AllTrucksListViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 9/19/22.
//

import UIKit

class AllTrucksListViewController: UIViewController {

  private var allTrucks: [Truck] = []
  private let tableView: UITableView = {
    let table = UITableView()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    table.enableAutolayout()
    return table
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .background
    title = "Empresas fleteras".uppercased()

    tableView.dataSource = self
    tableView.delegate = self

    setupSubviews()
    setupConstraints()
    setupTopBarActions()

    loadTrucks()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()
  }

  private func setupSubviews() {
    view.addSubview(tableView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
    ])
  }

  private func setupTopBarActions() {
    let addEmployeesItem = UIBarButtonItem(image: .personFillBadgePlus, style: .plain, target: self, action: #selector(goToAddTruckScreen))
    addEmployeesItem.tintColor = .primaryLabel
    navigationItem.rightBarButtonItem = addEmployeesItem
    navigationItem.backButtonTitle = ""
    navigationItem.backBarButtonItem?.tintColor = .label
  }

  @objc private func goToAddTruckScreen() {
    let addTruckViewController = AddTruckViewController()
    navigationController?.pushViewController(addTruckViewController, animated: true)
  }

  private func loadTrucks() {
    FirebaseService.shared.getTrucks { [weak self] trucks in
      guard let self = self, let trucks = trucks else { return }
      self.allTrucks = trucks
      self.tableView.reloadData()
    }
  }
}

extension AllTrucksListViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allTrucks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    cell.textLabel?.text = allTrucks[indexPath.row].id
    return cell
  }
}

extension AllTrucksListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Selected truck number: \(allTrucks[indexPath.row])")
  }
}
