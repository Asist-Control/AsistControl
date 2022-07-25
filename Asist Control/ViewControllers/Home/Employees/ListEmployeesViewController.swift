//
//  ListEmployeesViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 6/22/22.
//

import UIKit

class ListEmployeesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        title = "Empleados"
        
        let addEmployeesItem = UIBarButtonItem(image: UIImage(systemName: "person.fill.badge.plus"), style: .plain, target: self, action: #selector(addEmployee))
        addEmployeesItem.tintColor = .primaryLabel
        navigationItem.rightBarButtonItem = addEmployeesItem
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem?.tintColor = .label
    }

    @objc private func addEmployee() {
        let vc = AddEmployeeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
