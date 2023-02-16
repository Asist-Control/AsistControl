//
//  AddEmployeeViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 6/22/22.
//

import UIKit

class AddEmployeeViewController: UIViewController, EmployeeControllerDelegate {
    
  private let containerHeightValue: CGFloat = 1180
  private let spacing: CGFloat = 15
  private let sidePadding: CGFloat = 20
  
  private let scrollView: UIScrollView = {
    let sv = UIScrollView()
    sv.enableAutolayout()
    
    return sv
  }()
  
  private let container: UIView = {
    let view = UIView()
    view.enableAutolayout()
    
    return view
  }()
  
  private let nameField: TextInputView = {
    let field = TextInputView()
    field.configure(withStyle: .name, title: "Nombre")
    field.enableAutolayout()
    
    return field
  }()
  
  private let lastNameField: TextInputView = {
    let field = TextInputView()
    field.configure(withStyle: .name, title: "Apellido")
    field.enableAutolayout()
    
    return field
  }()
  
  private let emailField: TextInputView = {
    let field = TextInputView()
    field.configure(withStyle: .email, title: "Email")
    field.enableAutolayout()
    
    return field
  }()
  
  private let birthDate: ACDateField = {
    let date = ACDateField()
    date.configure(withTitle: "Fecha de Nacimiento")
    date.enableAutolayout()
    
    return date
  }()

  private let addressField: TextInputView = {
    let field = TextInputView()
    field.configure(withStyle: .address, title: "Dirección")
    field.enableAutolayout()
    
    return field
  }()
  
  private let phoneField: TextInputView = {
    let field = TextInputView()
    field.configure(withStyle: .phone, title: "Celular")
    field.enableAutolayout()
    
    return field
  }()
  
  private let identityCardField: TextInputView = {
    let field = TextInputView()
    field.configure(withStyle: .ci, title: "Cédula")
    field.enableAutolayout()
    
    return field
  }()
  
  private let civilStateField: TextInputView = {
    let field = TextInputView()
    field.configure(withStyle: .normal, title: "Estado Civil")
    field.enableAutolayout()
    
    return field
  }()
  
  private let employeeRoleDropDown: ACDropDown = {
    let dd = ACDropDown()
    dd.enableAutolayout()
    
    return dd
  }()
  
  private let bpsCompanyDropDown: ACDropDown = {
    let dd = ACDropDown()
    dd.enableAutolayout()
    
    return dd
  }()
  
  private let numberOfKids: TextInputView = {
    let field = TextInputView()
    field.configure(withStyle: .number, title: "Cantidad de Hijos")
    field.enableAutolayout()
    
    return field
  }()
  
  private let addEmployeeButton: ACButton = {
    let button = ACButton()
    button.title = "Agregar".uppercased()
    button.enableAutolayout()
    
    return button
  }()
  
  private lazy var controller = EmployeeController(delegate: self)
      
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .background
    title = "Agregar empleado".capitalized
    navigationItem.backButtonTitle = ""
    navigationItem.backBarButtonItem?.tintColor = .label
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    setupSubviews()
    setupConstraints()
    setupActions()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    let tapAction = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tapAction)
  }
  
  private func setupSubviews() {
    view.addSubview(scrollView)
    
    scrollView.addSubview(container)
    
    container.addSubview(nameField)
    container.addSubview(lastNameField)
    container.addSubview(emailField)
    container.addSubview(birthDate)
    container.addSubview(addressField)
    container.addSubview(phoneField)
    container.addSubview(identityCardField)
    container.addSubview(civilStateField)
    container.addSubview(employeeRoleDropDown)
    container.addSubview(bpsCompanyDropDown)
    container.addSubview(numberOfKids)
    
    container.addSubview(addEmployeeButton)
    
    setupDropdowns()
  }
  
  var containerHeight: NSLayoutConstraint?
  var buttonBottomDistance: NSLayoutConstraint?
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -sidePadding),
      
      container.topAnchor.constraint(equalTo: scrollView.topAnchor),
      container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      container.widthAnchor.constraint(equalTo: view.widthAnchor),
      
      nameField.topAnchor.constraint(equalTo: container.topAnchor, constant: sidePadding),
      nameField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      nameField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      nameField.heightAnchor.constraint(equalToConstant: TextInputView.height),
      
      lastNameField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: spacing),
      lastNameField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      lastNameField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      lastNameField.heightAnchor.constraint(equalToConstant: TextInputView.height),
      
      emailField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: spacing),
      emailField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      emailField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      emailField.heightAnchor.constraint(equalToConstant: TextInputView.height),
      
      birthDate.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: spacing),
      birthDate.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      birthDate.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      birthDate.heightAnchor.constraint(equalToConstant: TextInputView.height),
      
      addressField.topAnchor.constraint(equalTo: birthDate.bottomAnchor, constant: spacing),
      addressField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      addressField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      addressField.heightAnchor.constraint(equalToConstant: TextInputView.height),
      
      phoneField.topAnchor.constraint(equalTo: addressField.bottomAnchor, constant: spacing),
      phoneField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      phoneField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      phoneField.heightAnchor.constraint(equalToConstant: TextInputView.height),
      
      identityCardField.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: spacing),
      identityCardField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      identityCardField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      identityCardField.heightAnchor.constraint(equalToConstant: TextInputView.height),
      
      civilStateField.topAnchor.constraint(equalTo: identityCardField.bottomAnchor, constant: spacing),
      civilStateField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      civilStateField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      civilStateField.heightAnchor.constraint(equalToConstant: TextInputView.height),
      
      employeeRoleDropDown.topAnchor.constraint(equalTo: civilStateField.bottomAnchor, constant: spacing),
      employeeRoleDropDown.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      employeeRoleDropDown.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      employeeRoleDropDown.heightAnchor.constraint(equalToConstant: TextInputView.height),
      
      bpsCompanyDropDown.topAnchor.constraint(equalTo: employeeRoleDropDown.bottomAnchor, constant: spacing),
      bpsCompanyDropDown.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      bpsCompanyDropDown.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      bpsCompanyDropDown.heightAnchor.constraint(equalToConstant: TextInputView.height),
      
      numberOfKids.topAnchor.constraint(equalTo: bpsCompanyDropDown.bottomAnchor, constant: spacing),
      numberOfKids.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      numberOfKids.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      numberOfKids.heightAnchor.constraint(equalToConstant: TextInputView.height),
      
      addEmployeeButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -30),
      addEmployeeButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: sidePadding),
      addEmployeeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -sidePadding),
      addEmployeeButton.heightAnchor.constraint(equalToConstant: 56)
    ])
    containerHeight = container.heightAnchor.constraint(equalToConstant: containerHeightValue)
    containerHeight?.isActive = true
    
    buttonBottomDistance = addEmployeeButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -30)
    buttonBottomDistance?.isActive = true
  }
  
  private func setupActions() {
    addEmployeeButton.addTarget(self, action: #selector(addEmployeeButtonPressed), for: .touchUpInside)
  }
  
  private func setupDropdowns() {
    let employeeDataSource = Role.allCases.map { $0.rawValue }
    employeeRoleDropDown.configure(withTitle: "Seleccionar Rol", with: employeeDataSource)
    
    let bpsCompanyDataSource = BPSCompany.allCases.map { $0.rawValue }
    bpsCompanyDropDown.configure(withTitle: "Empresa BPS", with: bpsCompanyDataSource)
  }
  
  private func allFieldsAreComplete() -> Employee? {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM/dd/yyyy"
      
    guard
      let name = nameField.currentText, !name.isEmpty,
      let lastName = lastNameField.currentText, !lastName.isEmpty,
      let email = emailField.currentText, !email.isEmpty,
      let birth = birthDate.currentText, !birth.isEmpty,
      let address = addressField.currentText, !address.isEmpty,
      let phone = phoneField.currentText, !phone.isEmpty,
      let ci = identityCardField.currentText, !ci.isEmpty,
      let civilState = civilStateField.currentText, !civilState.isEmpty,
      let noOfKids = numberOfKids.currentText, !noOfKids.isEmpty,
      let date = dateFormatter.date(from: birth)
    else { return nil }

    let employee = Employee(firstName: name,
                            lastName: lastName,
                            ci: ci,
                            companyBPS: BPSCompany(rawValue: bpsCompanyDropDown.text) ?? .rustic,
                            role: Role(rawValue: employeeRoleDropDown.text) ?? .assistant,
                            birthDate: date,
                            address: address,
                            phone: phone,
                            email: email,
                            truck: "",
                            civilState: civilState,
                            numberOfKids: Int(noOfKids) ?? 0)
    
    return employee
  }
  
  private func add(employee: Employee) {
    controller.addEmployee(employee)
  }
  
  func employeeWasAdded(_ sucess: Bool) {
    let alert = UIAlertController(title: "Empleado agregado!", message: "Se ha agregado al empleado correctamente", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak self] _ in
      self?.navigationController?.popViewController(animated: true)
    }))
    present(alert, animated: true)
  }
  
  @objc private func addEmployeeButtonPressed() {
    if let employee = allFieldsAreComplete() {
      add(employee: employee)
    } else {
      let alert = UIAlertController(title: "Datos incompletos", message: "Todos los datos deben ser ingresados para crear un empleado", preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "Aceptar", style: .cancel)
      alert.addAction(cancelAction)
      
      present(alert, animated: true)
    }
  }
  
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      if view.frame.origin.y == 0 {
        let height = keyboardSize.height
        guard
          height > 0,
          let containerHeight = self.containerHeight,
          let buttonBottomDistance = self.buttonBottomDistance
        else { return }
        containerHeight.constant = containerHeightValue + height
        buttonBottomDistance.constant = -10 - height
        view.layoutIfNeeded()
      }
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    guard let containerHeight = containerHeight else { return }
    containerHeight.constant = containerHeightValue
    buttonBottomDistance?.constant = -30
    view.layoutIfNeeded()
  }
}
