//
//  EmployeeEditableView.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 2/18/23.
//

import UIKit

protocol EmployeeEditableViewDelegate: AnyObject {
  func changeEmployeeWasTapped(for targetView: UIView)
}

class EmployeeEditableView: UIView {
  
  // MARK: - Properties
  
  private var employee: Employee?
  private var canEdit: Bool = true
  private var role: Role = .driver
  private var parent: UIView?
  weak var delegate: EmployeeEditableViewDelegate?
  
  private let imageSize: CGFloat = 30
  private let margin: CGFloat = 5
  private let bigMargin: CGFloat = 10
  private let cornerRadious: CGFloat = 10
  
  private let containerStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fillProportionally
    stack.enableAutolayout()
    
    return stack
  }()
  
  private let leftImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    image.enableAutolayout()
    
    return image
  }()
  
  private let changeImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    image.isUserInteractionEnabled = true
    image.enableAutolayout()
    
    return image
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .h3
    label.numberOfLines = 0
    label.enableAutolayout()
    
    return label
  }()
  
  convenience init(employee: Employee, for parent: UIView, canEdit: Bool = true, for role: Role) {
    self.init(frame: .zero)
    self.employee = employee
    self.canEdit = canEdit
    self.parent = parent
    self.role = role
    
    enableAutolayout()
    setupView()
  }
  
  private func setupView() {
    backgroundColor = .white
    layer.cornerRadius = cornerRadious
    
    addSubview(containerStack)
    containerStack.spacing = bigMargin
    NSLayoutConstraint.activate([
      containerStack.topAnchor.constraint(equalTo: topAnchor, constant: bigMargin),
      containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
      containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
      containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
      
      leftImage.widthAnchor.constraint(equalToConstant: imageSize),
      
      changeImage.widthAnchor.constraint(equalToConstant: imageSize * 0.8)
    ])
    
    containerStack.addArrangedSubview(leftImage)
    containerStack.addArrangedSubview(nameLabel)
    if canEdit {
      containerStack.addArrangedSubview(changeImage)
      addActionToChangeImage()
    }
    
    updateEmployeeName()
    leftImage.image = role == .driver ? UIImage(named: "driverSymbol") : UIImage(named: "helperSymbol")
    changeImage.image = UIImage(named: "changePers")
  }
  
  private func addActionToChangeImage() {
    let tapAction = UITapGestureRecognizer(target: self, action: #selector(changeEmployee))
    changeImage.addGestureRecognizer(tapAction)
  }
  
  private func updateEmployeeName() {
    guard let employee else { return }
    
    nameLabel.text = employee.displayName
  }
  
  func getEmployee() -> Employee? {
    return employee
  }
  
  func updateEmployee(newEmployee: Employee) {
    removeTruckFromPreviousEmployee()
    employee = newEmployee
    updateEmployeeName()
  }
  
  func removeTruckFromPreviousEmployee() {
    employee?.truck = ""
  }
  
  @objc private func changeEmployee() {
    delegate?.changeEmployeeWasTapped(for: self)
  }
}
