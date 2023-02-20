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

  let employeeDetailView = EmployeeDetailsView()

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
    employeeDetailView.delegate = self
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

  private func reloadTable() {
    controller.loadEmployees()
  }

}

extension ListEmployeesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return employees.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    cell.textLabel?.text = employees[indexPath.row].displayName
    cell.selectionStyle = .none
    cell.backgroundColor = .clear
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let employee = employees[indexPath.row]
    employeeDetailView.configure(with: employee, for: self)
  }
}

extension ListEmployeesViewController: EmployeeDetailsViewDelegate {
  func removeEmployee(_ employee: Employee) {
    controller.deleteEmployee(employee) { [weak self] success in
      if success {
        self?.employeeDetailView.closeView()
        let alert = UIAlertController(title: "Empleado eliminado", message: "\(employee.displayName) ha sido eliminado", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Continuar", style: .default) { _ in
          self?.reloadTable()
        }
        alert.addAction(cancelAction)
        self?.present(alert, animated: true)
      } else {
        let alert = UIAlertController(title: "Error", message: "No se pudo elimiar el empleado", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alert.addAction(cancelAction)
        self?.present(alert, animated: true)
      }
    }
  }
}

extension ListEmployeesViewController: UITableViewDelegate {
  
}
