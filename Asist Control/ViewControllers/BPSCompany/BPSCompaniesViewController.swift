//
//  BPSCompaniesViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 2/4/23.
//

import UIKit

class BPSCompaniesViewController: UIViewController, BPSCompanyControllerDelegate {

  // MARK: - Subviews
  private let tableView: UITableView = {
    let table = UITableView()
    table.backgroundColor = .clear
    table.enableAutolayout()
    
    return table
  }()
  
  // MARK: - Properties
  private var items: [BPSCompany] = []
  private lazy var controller = BPSCompanyController(delegate: self)
  private var delegate: EmployeeControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupSubviews()
    setupConstraints()
    setupTopBarActions()
    setupTableContent()
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

  private func setupTopBarActions() {
    title = "Empresas BPS"
    
    let addBPSCompany = UIBarButtonItem(image: .personFillBadgePlus, style: .plain, target: self, action: #selector(addBpsCompany))
    addBPSCompany.tintColor = .primaryLabel
    navigationItem.rightBarButtonItem = addBPSCompany
    navigationItem.backButtonTitle = ""
    navigationItem.backBarButtonItem?.tintColor = .label
  }

  private func setupTableContent() {
    items = controller.getBPSCompanies()
    tableView.reloadData()
  }

  @objc private func addBpsCompany() {
    let vc = AddBPSCompanyViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension BPSCompaniesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let item = items[indexPath.row]
    cell.textLabel?.text = item.rawValue

    return cell
  }
  
}

extension BPSCompaniesViewController: UITableViewDelegate {
  
}
