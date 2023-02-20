//
//  EmployeeDetailsView.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 2/20/23.
//

import UIKit

protocol EmployeeDetailsViewDelegate {
  func removeEmployee(_ employee: Employee)
}

final class EmployeeDetailsView: UIView {

  private var employee: Employee?
  private var parent: UIViewController?

  var delegate: EmployeeDetailsViewDelegate?

  private let smallSpacing: CGFloat = 5
  private let mediumSpacing: CGFloat = 10
  private let bigSpacing: CGFloat = 15
  private let closeButtonSize: CGFloat = 30

  private let overlay: UIView = {
    let view = UIView()
    view.backgroundColor = .lightGray
    view.alpha = 0.3
    view.enableAutolayout()
    return view
  }()

  private let closeButton: UIImageView = {
    let image = UIImageView()
    image.image = .multiply
    image.contentMode = .scaleAspectFit
    image.isUserInteractionEnabled = true
    image.tintColor = .asistDarkBlue
    image.enableAutolayout()
    return image
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .h1
    label.textColor = .asistDarkBlue
    label.textAlignment = .center
    label.numberOfLines = 0
    label.enableAutolayout()
    return label
  }()

  private let ciLabel: UILabel = {
    let label = UILabel()
    label.font = .h3
    label.textColor = .asistDarkBlue
    label.textAlignment = .center
    label.enableAutolayout()
    return label
  }()

  private let truckTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Camión:"
    label.font = .body1Bold
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let truckLabel: UILabel = {
    let label = UILabel()
    label.font = .body1
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let birthDateTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Fecha de Nacimiento:"
    label.font = .body1Bold
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let birthDateLabel: UILabel = {
    let label = UILabel()
    label.font = .body1
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let phoneTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Celular:"
    label.font = .body1Bold
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let phoneLabel: UILabel = {
    let label = UILabel()
    label.font = .body1
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let emailTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Email:"
    label.font = .body1Bold
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let emailLabel: UILabel = {
    let label = UILabel()
    label.font = .body1
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let civilStateTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Estado Civil:"
    label.font = .body1Bold
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let civilStateLabel: UILabel = {
    let label = UILabel()
    label.font = .body1
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let noOfKidsTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Cantidad de hijos:"
    label.font = .body1Bold
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let noOfKidsLabel: UILabel = {
    let label = UILabel()
    label.font = .body1
    label.textColor = .asistDarkBlue
    label.enableAutolayout()
    return label
  }()

  private let deleteButton: ACButton = {
    let button = ACButton()
    button.title = "Eliminar"
    button.backgroundColor = .clear
    button.setTitleColor(.red, for: .normal)
    button.setTitleColor(.gray, for: .disabled)
    button.enableAutolayout()
    return button
  }()

  private let canNotDeleteLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 9, weight: .light)
    label.text = "No se puede elimiar el empleado ya que tiene un camion asignado. Remuevalo del camion y vuelva a intentarlo"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.enableAutolayout()
    return label
  }()

  func configure(with employee: Employee, for parent: UIViewController) {
    setupView()
    setupSubviews()
    setupConstraints()

    self.employee = employee
    self.parent = parent

    setupTexts()
    setupViewOnParent()
    setupDeleteButton()
  }

  private func setupView() {
    enableAutolayout()
    backgroundColor = .background
    layer.cornerRadius = 20

    setupCloseButton()
  }

  private func setupSubviews() {
    addSubview(closeButton)
    addSubview(nameLabel)
    addSubview(ciLabel)
    addSubview(truckTitleLabel)
    addSubview(truckLabel)
    addSubview(birthDateTitleLabel)
    addSubview(birthDateLabel)
    addSubview(phoneTitleLabel)
    addSubview(phoneLabel)
    addSubview(emailTitleLabel)
    addSubview(emailLabel)
    addSubview(civilStateTitleLabel)
    addSubview(civilStateLabel)
    addSubview(noOfKidsTitleLabel)
    addSubview(noOfKidsLabel)
    addSubview(deleteButton)
    addSubview(canNotDeleteLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      closeButton.topAnchor.constraint(equalTo: topAnchor, constant: smallSpacing),
      closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -smallSpacing),
      closeButton.widthAnchor.constraint(equalToConstant: closeButtonSize),
      closeButton.heightAnchor.constraint(equalToConstant: closeButtonSize),

      nameLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: bigSpacing),
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mediumSpacing),
      nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -mediumSpacing),

      ciLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: smallSpacing),
      ciLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mediumSpacing),
      ciLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -mediumSpacing),

      truckTitleLabel.topAnchor.constraint(equalTo: ciLabel.bottomAnchor, constant: bigSpacing),
      truckTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mediumSpacing),

      truckLabel.topAnchor.constraint(equalTo: ciLabel.bottomAnchor, constant: bigSpacing),
      truckLabel.leadingAnchor.constraint(equalTo: truckTitleLabel.trailingAnchor, constant: smallSpacing),

      birthDateTitleLabel.topAnchor.constraint(equalTo: truckTitleLabel.bottomAnchor, constant: bigSpacing),
      birthDateTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mediumSpacing),
      
      birthDateLabel.topAnchor.constraint(equalTo: truckLabel.bottomAnchor, constant: bigSpacing),
      birthDateLabel.leadingAnchor.constraint(equalTo: birthDateTitleLabel.trailingAnchor, constant: smallSpacing),

      phoneTitleLabel.topAnchor.constraint(equalTo: birthDateTitleLabel.bottomAnchor, constant: bigSpacing),
      phoneTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mediumSpacing),
      
      phoneLabel.topAnchor.constraint(equalTo: birthDateLabel.bottomAnchor, constant: bigSpacing),
      phoneLabel.leadingAnchor.constraint(equalTo: phoneTitleLabel.trailingAnchor, constant: smallSpacing),

      emailTitleLabel.topAnchor.constraint(equalTo: phoneTitleLabel.bottomAnchor, constant: bigSpacing),
      emailTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mediumSpacing),
      
      emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: bigSpacing),
      emailLabel.leadingAnchor.constraint(equalTo: emailTitleLabel.trailingAnchor, constant: smallSpacing),

      civilStateTitleLabel.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: bigSpacing),
      civilStateTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mediumSpacing),
      
      civilStateLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: bigSpacing),
      civilStateLabel.leadingAnchor.constraint(equalTo: civilStateTitleLabel.trailingAnchor, constant: smallSpacing),

      noOfKidsTitleLabel.topAnchor.constraint(equalTo: civilStateTitleLabel.bottomAnchor, constant: bigSpacing),
      noOfKidsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mediumSpacing),
      
      noOfKidsLabel.topAnchor.constraint(equalTo: civilStateLabel.bottomAnchor, constant: bigSpacing),
      noOfKidsLabel.leadingAnchor.constraint(equalTo: noOfKidsTitleLabel.trailingAnchor, constant: smallSpacing),

      deleteButton.topAnchor.constraint(equalTo: noOfKidsLabel.bottomAnchor, constant: bigSpacing * 2),
      deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bigSpacing),
      deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -bigSpacing),

      canNotDeleteLabel.topAnchor.constraint(equalTo: deleteButton.bottomAnchor),
      canNotDeleteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bigSpacing),
      canNotDeleteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -bigSpacing),
      canNotDeleteLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bigSpacing)
    ])
  }

  private func setupTexts() {
    nameLabel.text = employee?.displayName
    ciLabel.text = employee?.ci.toCIFormat()
    truckLabel.text = employee?.truck
    phoneLabel.text = employee?.phone
    emailLabel.text = employee?.email
    civilStateLabel.text = employee?.civilState
    noOfKidsLabel.text = "\(employee?.numberOfKids ?? 0) hijos"
    setupBirthDate()
  }

  private func setupViewOnParent() {
    guard let parent else { return }
    parent.view.addSubview(overlay)
    parent.view.addSubview(self)
    
    overlay.frame = parent.view.bounds

    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: parent.view.leadingAnchor, constant: bigSpacing + mediumSpacing),
      trailingAnchor.constraint(equalTo: parent.view.trailingAnchor, constant: -(bigSpacing + mediumSpacing)),
      centerYAnchor.constraint(equalTo: parent.view.centerYAnchor)
    ])
  }

  private func setupCloseButton() {
    let tapAction = UITapGestureRecognizer(target: self, action: #selector(closeView))
    closeButton.addGestureRecognizer(tapAction)
  }

  private func setupDeleteButton() {
    deleteButton.addTarget(self, action: #selector(deleteEmployeeAlert), for: .touchUpInside)

    guard let employee else { return }
    deleteButton.isEnabled = employee.truck.isEmpty || employee.truck == "-"
    canNotDeleteLabel.isHidden = deleteButton.isEnabled
  }

  @objc func closeView() {
    overlay.removeFromSuperview()
    removeFromSuperview()
  }

  @objc private func deleteEmployeeAlert() {
    let alert = UIAlertController(title: "Eliminar empleado", message: "Estas seguro que deseas eliminar a \(employee?.displayName ?? "")", preferredStyle: .actionSheet)
    let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
    let deleteAction = UIAlertAction(title: "Eliminar", style: .destructive) { _ in
      self.deleteEmployee()
      print("Eliminar a \(self.employee?.displayName ?? "")")
    }
    alert.addAction(deleteAction)
    alert.addAction(cancelAction)
    parent?.present(alert, animated: true)
  }

  private func deleteEmployee() {
    guard let employee else { return }
    delegate?.removeEmployee(employee)
  }

  private func setupBirthDate() {
    guard let employee else { return }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yy"
    birthDateLabel.text = dateFormatter.string(from: employee.birthDate)
  }
}
