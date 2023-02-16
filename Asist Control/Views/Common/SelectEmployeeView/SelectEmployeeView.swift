//
//  SelectEmployeeView.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 11/29/22.
//

import UIKit

enum SelectEmployeeViewType {
  case driver, helper
}

class SelectEmployeeView: UIView {

  private var parent: UIViewController?
  var type: SelectEmployeeViewType? {
    didSet {
      setupEmployeeName()
      setupActions()
    }
  }
  private(set) var employee: Employee? {
    didSet {
      setupEmployeeName()
    }
  }

  private let employeeLabel: UILabel = {
    let label = UILabel()
    label.isUserInteractionEnabled = true
    label.enableAutolayout()

    return label
  }()

  private let removeSelectionButton: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.image = .multiply
    imageView.tintColor = .black
    imageView.isUserInteractionEnabled = true
    imageView.backgroundColor = .red
    imageView.enableAutolayout()

    return imageView
  }()

  convenience init(parent: UIViewController) {
    self.init(frame: .zero)
    self.parent = parent
    enableAutolayout()

    backgroundColor = .inputBackground
    layer.cornerRadius = TextInputView.cornerRadius

    setupSubviews()
    setupConstraints()
    setupEmployeeName()
  }

  private func setupSubviews() {
    addSubview(employeeLabel)
    addSubview(removeSelectionButton)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      employeeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      employeeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      employeeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

      removeSelectionButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      removeSelectionButton.leadingAnchor.constraint(equalTo: employeeLabel.trailingAnchor, constant: 10),
      removeSelectionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      removeSelectionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
      removeSelectionButton.widthAnchor.constraint(equalToConstant: employeeLabel.intrinsicContentSize.height)
    ])
  }

  private func setupActions() {
    guard let type else { return }

    switch type {
    case .driver:
      let driverTapAction = UITapGestureRecognizer(target: self, action: #selector(driverLabelSelected))
      employeeLabel.addGestureRecognizer(driverTapAction)
    case .helper:
      let helperTapAction = UITapGestureRecognizer(target: self, action: #selector(helperLabelSelected))
      employeeLabel.addGestureRecognizer(helperTapAction)
    }

    let removeSelectionAction = UITapGestureRecognizer(target: self, action: #selector(removeSelection))
    removeSelectionButton.addGestureRecognizer(removeSelectionAction)
  }

  @objc private func driverLabelSelected(_ sender: UITapGestureRecognizer) {
    guard let parent else { return }
    let allEmployeesList = AllEmployeesListView()
    allEmployeesList.delegate = self
    allEmployeesList.configure(for: sender.view, filteredBy: .driversWithoutTruck)
    
    parent.view.addSubview(allEmployeesList)
    allEmployeesList.centerXAnchor.constraint(equalTo: parent.view.centerXAnchor).isActive = true
    allEmployeesList.centerYAnchor.constraint(equalTo: parent.view.centerYAnchor).isActive = true
  }

  @objc private func helperLabelSelected(_ sender: UITapGestureRecognizer) {
    guard let parent else { return }
    let allEmployeesList = AllEmployeesListView()
    allEmployeesList.delegate = self
    allEmployeesList.configure(for: sender.view, filteredBy: .withoutTruck)
    
    parent.view.addSubview(allEmployeesList)
    allEmployeesList.centerXAnchor.constraint(equalTo: parent.view.centerXAnchor).isActive = true
    allEmployeesList.centerYAnchor.constraint(equalTo: parent.view.centerYAnchor).isActive = true
  }

  @objc private func removeSelection() {
    employee = nil
  }

  private func setupEmployeeName() {
    employeeLabel.text = employee == nil ? (type == .driver ? "Seleccionar chofer" : "Seleccionar empleado") : employee?.displayName
  }
}

extension SelectEmployeeView: AllEmployeesListViewDelegate {
  func employeeSelected(with employee: Employee, for view: AllEmployeesListView, target: UIView?) {
    self.employee = employee
  }
}
  
