//
//  AlEmployeesListView.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 9/24/22.
//

import UIKit

protocol AllEmployeesListViewDelegate {
  func employeeSelected(with employee: Employee, for view: AllEmployeesListView, target: UIView?)
}

enum EmployeesViewFilter {
  case all
  case drivers
  case helpers
  case withoutTruck
  case withTruck
  case driversWithoutTruck
  case helpersWithoutTruck
  case notOn(truckID: String)
}

class AllEmployeesListView: UIView {

  private var employees: [Employee] = []

  private let dismissImageSize: CGFloat = 30

  private let headerView = GenericHeaderView()
  private var targetView: UIView?
  private var filter: EmployeesViewFilter = .all

  private let dismissImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    image.image = .multiply
    image.tintColor = .black
    image.isUserInteractionEnabled = true
    image.enableAutolayout()
    
    return image
  }()

  private let tableView: UITableView = {
    let table = UITableView()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    table.enableAutolayout()

    return table
  }()

  var delegate: AllEmployeesListViewDelegate?

  private let activityIndicator = UIActivityIndicatorView()

  func configure(for view: UIView? = nil, filteredBy: EmployeesViewFilter = .all) {
    targetView = view
    filter = filteredBy
    enableAutolayout()
    backgroundColor = .white
    layer.cornerRadius = 20

    fetchEmployees()

    setupSubviews()
    setupConstraints()
    setupDismissAction()
  }

  private func setupSubviews() {
    addSubview(headerView)
    headerView.configure(for: self, with: nil, action: nil)

    addSubview(tableView)
    tableView.dataSource = self
    tableView.delegate = self

    addSubview(activityIndicator)
    activityIndicator.stopAnimating()
    activityIndicator.enableAutolayout()
  }

  private func setupConstraints() {
    let widthScreen = UIScreen.main.bounds.width
    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: widthScreen - 40),
      heightAnchor.constraint(equalToConstant: widthScreen + 40),

      headerView.topAnchor.constraint(equalTo: topAnchor),
      headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: trailingAnchor),

      tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

      activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }

  private func setupDismissAction() {
    let tapAction = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
    dismissImage.addGestureRecognizer(tapAction)
  }
  
  @objc private func dismissPopUp() {
    removeFromSuperview()
  }

  private func fetchEmployees() {
    activityIndicator.startAnimating()
    employees = Current.shared.employees.filter { employee in
      switch self.filter {
      case .drivers:
        return employee.role == .driver
      case .helpers:
        return employee.role == .assistant
      case .withoutTruck:
        return employee.truck == "" || employee.truck == "-"
      case .withTruck:
        return employee.truck != "" || employee.truck != "-"
      case .notOn(let truckID):
        return employee.truck != truckID
      case .driversWithoutTruck:
        return employee.role == .driver && employee.truck == "" || employee.truck == "-"
      case .helpersWithoutTruck:
        return employee.role == .assistant && employee.truck == "" || employee.truck == "-"
      default:
        return true
      }
    }
    self.tableView.reloadData()
    self.activityIndicator.stopAnimating()
  }
}

extension AllEmployeesListView: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    employees.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let employee = employees[indexPath.row]
    cell.textLabel?.text = employee.displayName

    return cell
  }

}

extension AllEmployeesListView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let employee = employees[indexPath.row]
    delegate?.employeeSelected(with: employee, for: self, target: targetView)
    removeFromSuperview()
  }
}
