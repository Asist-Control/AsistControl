//
//  MenuViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/13/22.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.isUserInteractionEnabled = true
        stack.enableAutolayout()
        
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menú"
        navigationController?.navigationBar.topItem?.titleView?.tintColor = .primaryLabel
        view.backgroundColor = .background
        
        setupSubviews()
        setupConstraints()
        setupItems()
    }
    
    private func setupItems() {
        let home = MenuCellView(
            title: "Inicio",
            subtitle: "",
            icon: UIImage(systemName: "house.fill"),
            action: {
                print("Inicio fue seleccionada")
            }
        )
        containerStack.addArrangedSubview(home)
        
        let extraHours = MenuCellView(
            title: "Horas extras",
            subtitle: "Agregar, Editar, Eliminar",
            icon: UIImage(systemName: "person.badge.clock.fill"),
            action: {
                print("Horas extras fue seleccionada")
            }
        )
        containerStack.addArrangedSubview(extraHours)
        
        let absents = MenuCellView(
            title: "Faltas",
            subtitle: "Agregar, Editar, Eliminar",
            icon: UIImage(systemName: "clock.badge.exclamationmark"),
            action: {
                print("Faltas fue seleccionada")
            }
        )
        containerStack.addArrangedSubview(absents)
        
        let resports = MenuCellView(
            title: "Reportes",
            subtitle: "",
            icon: UIImage(systemName: "doc.text.fill"),
            action: {
                print("Reportes fue seleccionada")
            }
        )
        containerStack.addArrangedSubview(resports)
        
        let employees = MenuCellView(
            title: "Empleados",
            subtitle: "Agregar, Editar, Eliminar",
            icon: UIImage(systemName: "person.fill"),
            action: { [weak self] in
                print("Empleados fue seleccionada")
                guard let self = self else { return }
                let vc = ListEmployeesViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        )
        containerStack.addArrangedSubview(employees)
        
        let addTruck = MenuCellView(
            title: "Empresas Fleteras",
            subtitle: "Agregar, Editar, Eliminar",
            icon: UIImage(systemName: "train.side.front.car"),
            action: {
                print("Empresas Fleteras fue seleccionada")
            }
        )
        containerStack.addArrangedSubview(addTruck)
        
        let companyBPS = MenuCellView(
            title: "Empresas BPS",
            subtitle: "Agregar, Editar, Eliminar",
            icon: UIImage(systemName: "scroll.fill"),
            action: {
                print("Empresas BPS fue seleccionada")
            }
        )
        containerStack.addArrangedSubview(companyBPS)
        
        let users = MenuCellView(
            title: "Usuarios",
            subtitle: "Agregar, Editar, Eliminar",
            icon: UIImage(systemName: "person.circle.fill"),
            action: {
                print("Usuarios fue seleccionada")
            }
        )
        containerStack.addArrangedSubview(users)
    }

    private func setupSubviews() {
        view.addSubview(containerStack)
        
        let closeItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(dismissViewController))
        closeItem.tintColor = .label
        navigationItem.rightBarButtonItem = closeItem
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            containerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}
