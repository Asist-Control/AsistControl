//
//  AddTruckViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 10/25/22.
//

import UIKit

class AddTruckViewController: UIViewController {

  private let fieldHeight = CGFloat(50)
  private var controller = TruckController()

  private let container: UIView = {
    let view = UIView()
    view.enableAutolayout()
    
    return view
  }()
  
  private let truckID: TextInputView = {
    let field = TextInputView()
    field.configure(withStyle: .name, title: "Truck ID")
    field.enableAutolayout()
    
    return field
  }()

  private let employeesTitleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.text = "Empleados"
    label.font = .body2Bold
    label.textColor = .primaryLabel
    label.textAlignment = .left
    label.enableAutolayout()
    return label
  }()

  private lazy var driverField = SelectEmployeeView(parent: self)
  private lazy var helperOneField = SelectEmployeeView(parent: self)
  private lazy var helperTwoField = SelectEmployeeView(parent: self)

  private let bpsCompanyDropDown: ACDropDown = {
    let dd = ACDropDown()
    dd.enableAutolayout()
    
    return dd
  }()

  private let isFixedDropDown: ACDropDown = {
    let dd = ACDropDown()
    dd.enableAutolayout()
    
    return dd
  }()

  private let addTruckButton: ACButton = {
    let button = ACButton()
    button.title = "Agregar".uppercased()
    button.enableAutolayout()
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    controller.attachController(self)

    view.backgroundColor = .background
    title = "Crear camión"

    setupSubviews()
    setupConstraints()
    setupDropdowns()
    setupActions()
  }

  private func setupSubviews() {
    setupEmployeeViews()
    view.addSubview(container)

    container.addSubview(truckID)
    container.addSubview(bpsCompanyDropDown)
    container.addSubview(employeesTitleLabel)
    container.addSubview(driverField)
    container.addSubview(helperOneField)
    container.addSubview(helperTwoField)
    container.addSubview(isFixedDropDown)
    container.addSubview(addTruckButton)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: view.topAnchor),
      container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      container.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      truckID.topAnchor.constraint(equalTo: container.topAnchor, constant: 120),
      truckID.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
      truckID.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),

      bpsCompanyDropDown.topAnchor.constraint(equalTo: truckID.bottomAnchor, constant: 20),
      bpsCompanyDropDown.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
      bpsCompanyDropDown.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
      bpsCompanyDropDown.heightAnchor.constraint(equalToConstant: TextInputView.height),

      employeesTitleLabel.topAnchor.constraint(equalTo: bpsCompanyDropDown.bottomAnchor, constant: 20),
      employeesTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
      employeesTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),

      driverField.topAnchor.constraint(equalTo: employeesTitleLabel.bottomAnchor, constant: 10),
      driverField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
      driverField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
      driverField.heightAnchor.constraint(equalToConstant: fieldHeight),

      helperOneField.topAnchor.constraint(equalTo: driverField.bottomAnchor, constant: 20),
      helperOneField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
      helperOneField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
      helperOneField.heightAnchor.constraint(equalToConstant: fieldHeight),

      helperTwoField.topAnchor.constraint(equalTo: helperOneField.bottomAnchor, constant: 20),
      helperTwoField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
      helperTwoField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
      helperTwoField.heightAnchor.constraint(equalToConstant: fieldHeight),

      isFixedDropDown.topAnchor.constraint(equalTo: helperTwoField.bottomAnchor, constant: 20),
      isFixedDropDown.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
      isFixedDropDown.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
      isFixedDropDown.heightAnchor.constraint(equalToConstant: TextInputView.height),

      addTruckButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
      addTruckButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      addTruckButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      addTruckButton.heightAnchor.constraint(equalToConstant: 56)
    ])
  }

  private func setupDropdowns() {
    let bpsCompanyDataSource = BPSCompany.allCases.map { $0.rawValue }
    bpsCompanyDropDown.configure(withTitle: "Empresa BPS", with: bpsCompanyDataSource)

    let isFixedDataSource = ["No", "Si"]
    isFixedDropDown.configure(withTitle: "Es fijo", with: isFixedDataSource)
  }

  private func setupActions() {
    addTruckButton.addTarget(self, action: #selector(addTruck), for: .touchUpInside)
  }

  @objc private func addTruck() {
    guard
      let truckNumber = truckID.currentText,
      let driver = driverField.employee,
      let helperOne = helperOneField.employee,
      let helperTwo = helperTwoField.employee,
      let bpsCompany = BPSCompany(rawValue: bpsCompanyDropDown.text)
    else {
      print("Complete todos los campos")
      return
    }

    guard validateEmployeesAreDifferent(one: driver, two: helperOne, three: helperTwo)
    else {
      print("No pueden haber empleados duplicados")
      return
    }

    let isFixed = isFixedDropDown.text.lowercased() == "si"

    let truck = Truck(
      id: truckNumber,
      driver: driver.ci,
      assistant1: helperOne.ci,
      assistant2: helperTwo.ci,
      companyBPS: bpsCompany,
      isFixed: isFixed)
    
    controller.uploadTruck(truck: truck)
  }

  private func validateEmployeesAreDifferent(one: Employee, two: Employee, three: Employee) -> Bool {
    return one.ci != two.ci && two.ci != three.ci && one.ci != three.ci
  }

  private func setupEmployeeViews() {
    driverField.type = .driver
    helperOneField.type = .helper
    helperTwoField.type = .helper
  }

  private func showSuccessfulAlert() {
    let alert = UIAlertController(title: "Camion agregado!", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Continuar", style: .default) { action in
      self.navigationController?.popViewController(animated: true)
    }
    alert.addAction(action)
    present(alert, animated: true)
  }
}

extension AddTruckViewController: TruckControllerDelegate {
  func truckWasAdded() {
    showSuccessfulAlert()
  }
}
  
