//
//  ListEmployeesViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 6/22/22.
//

import UIKit

class ListEmployeesViewController: UIViewController, EmployeeControllerDelegate {

  // MARK: - Subviews
  private let tableView: UITableView = {
    let table = UITableView()
    table.backgroundColor = .clear
    table.enableAutolayout()

    return table
  }()

  // MARK: - Properties
  private var employees: [Employee] = []
  private lazy var controller = EmployeeController(delegate: self)
  private var delegate: EmployeeControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupSubviews()
    setupTopBarActions()
    setupConstraints()

    delegate = self
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    controller.loadEmployees()
  }

  private func setupTopBarActions() {
    title = "Empleados"
    
    let addEmployeesItem = UIBarButtonItem(image: .personFillBadgePlus, style: .plain, target: self, action: #selector(addEmployee))
    addEmployeesItem.tintColor = .primaryLabel
    navigationItem.rightBarButtonItem = addEmployeesItem
    navigationItem.backButtonTitle = ""
    navigationItem.backBarButtonItem?.tintColor = .label
  }

  private func setupSubviews() {
    view.backgroundColor = .background

    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
    ])
  }

  @objc private func addEmployee() {
    let vc = AddEmployeeViewController()
    navigationController?.pushViewController(vc, animated: true)
  }

  func reloadEmployees(_ employees: [Any]) {
    guard let employees = employees as? [Employee] else { return }
    self.employees = employees
    tableView.reloadData()
  }

}

extension ListEmployeesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return employees.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    cell.textLabel?.text = employees[indexPath.row].displayName
    cell.backgroundColor = .clear
    return cell
  }
}

extension ListEmployeesViewController: UITableViewDelegate {
  
}
