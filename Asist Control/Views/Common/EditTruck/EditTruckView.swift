//
//  EditTruckView.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 9/23/22.
//

import UIKit

class EditTruckView: UIView {

  private var driverView: EmployeeEditableView?
  private var helperOneView: EmployeeEditableView?
  private var helperTwoView: EmployeeEditableView?
  var canEdit: Bool = true

  private let dismissImageSize: CGFloat = 30

  private weak var parent: UIView?
  private var truckSelected: Truck?

  private let headerView = GenericHeaderView()
  private let allEmployeesList = AllEmployeesListView()

  private let overlay: UIView = {
    let view = UIView()
    view.alpha = 0.6
    view.backgroundColor = .gray
    view.enableAutolayout()
    
    return view
  }()

  private let containerView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.distribution = .fillEqually
    stack.spacing = 5
    stack.enableAutolayout()

    return stack
  }()

  private let saveButton: ACButton = {
    let btn = ACButton()
    btn.setTitle("Guardar", for: .normal)
    btn.enableAutolayout()

    return btn
  }()

  private func setupView() {
    backgroundColor = .white
    layer.cornerRadius = 20
    enableAutolayout()

    addSubview(headerView)
    addSubview(containerView)
    addSubview(saveButton)

    setupConstraints()
  }

  private func setupConstraints() {
    let screenWidth = UIScreen.main.bounds.width
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: topAnchor),
      headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: trailingAnchor),

      containerView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

      saveButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
      saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      saveButton.widthAnchor.constraint(equalToConstant: 120),
      saveButton.heightAnchor.constraint(equalToConstant: 44),
      saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),

      widthAnchor.constraint(equalToConstant: screenWidth - 60),
      heightAnchor.constraint(equalToConstant: screenWidth)
    ])
  }

  func configure(with truck: Truck, for parent: UIView) {
    self.parent = parent
    truckSelected = truck

    setupOverlay()

    self.parent?.addSubview(self)

    setupView()
    headerView.configure(for: self, with: "Camión \(truck.id)") { [weak self] in
      self?.overlay.removeFromSuperview()
    }

    setupEmployeeViews()

    saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
  }

  private func setupEmployeeViews() {
    guard let truck = truckSelected, let parent = parent else { return }
    containerView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    guard let driver = truck.driver else { return }
    driverView = EmployeeEditableView(employee: driver, for: parent, canEdit: canEdit, for: .driver)
    if let driverView = driverView {
      driverView.delegate = self
      containerView.addArrangedSubview(driverView)
    }

    guard let helperOne = truck.assistant1 else { return }
    helperOneView = EmployeeEditableView(employee: helperOne, for: parent, canEdit: canEdit, for: .assistant)
    if let helperOneView = helperOneView {
      helperOneView.delegate = self
      containerView.addArrangedSubview(helperOneView)
    }

    guard let helperTwo = truck.assistant2 else { return }
    helperTwoView = EmployeeEditableView(employee: helperTwo, for: parent, canEdit: canEdit, for: .assistant)
    if let helperTwoView = helperTwoView {
      helperTwoView.delegate = self
      containerView.addArrangedSubview(helperTwoView)
    }
  }

  @objc private func saveAction() {
    guard let driver = driverView?.getEmployee(),
    let helperOne = helperOneView?.getEmployee(),
    let helperTwo = helperTwoView?.getEmployee()
    else { return }

    updateTruck(driver: driver, helperOne: helperOne, helperTwo: helperTwo)
    closeView()
  }

  private func updateTruck(driver: Employee, helperOne: Employee, helperTwo: Employee) {
    truckSelected?.updateTruck(driver: driver, helperOne: helperOne, helperTwo: helperTwo)
  }

  private func closeView() {
    overlay.removeFromSuperview()
    removeFromSuperview()
  }

  private func setupOverlay() {
    guard let parent = parent else { return }

    parent.addSubview(overlay)

    NSLayoutConstraint.activate([
      overlay.topAnchor.constraint(equalTo: parent.topAnchor),
      overlay.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
      overlay.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
      overlay.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
    ])
  }
}

extension EditTruckView: EmployeeEditableViewDelegate {
  func changeEmployeeWasTapped(for targetView: UIView) {
    guard let parent else { return }
    parent.addSubview(allEmployeesList)
    allEmployeesList.delegate = self
    allEmployeesList.configure(for: targetView, filteredBy: .withoutTruck)
    NSLayoutConstraint.activate([
      allEmployeesList.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
      allEmployeesList.centerYAnchor.constraint(equalTo: parent.centerYAnchor)
    ])
  }
}

extension EditTruckView: AllEmployeesListViewDelegate {
  func employeeSelected(with employee: Employee, for view: AllEmployeesListView, target: UIView?) {
    guard let target else { return }
    let editableView = target as? EmployeeEditableView
    editableView?.updateEmployee(newEmployee: employee)
    view.removeFromSuperview()
  }
}
