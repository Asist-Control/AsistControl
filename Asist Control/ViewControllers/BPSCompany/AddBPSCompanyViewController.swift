//
//  AddBPSCompanyViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 2/6/23.
//

import UIKit

class AddBPSCompanyViewController: UIViewController {

  private let sidePadding: CGFloat = 20

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

  private let addCompanyButton: ACButton = {
    let button = ACButton()
    button.title = "Agregar".uppercased()
    button.enableAutolayout()
    
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .background
    title = "Agregar Empresa BPS"
    navigationItem.backButtonTitle = ""
    navigationItem.backBarButtonItem?.tintColor = .label
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    setupSubviews()
    setupConstraints()
    setupActions()
  }

  private func setupSubviews() {
    view.addSubview(nameField)
    view.addSubview(addCompanyButton)
  }

  var buttonBottomDistance: NSLayoutConstraint?
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      nameField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
      nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
      
      addCompanyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
      addCompanyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
      addCompanyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
      addCompanyButton.heightAnchor.constraint(equalToConstant: 56)
    ])
  }

  private func setupActions() {
    
  }

  @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      if view.frame.origin.y == 0 {
        let height = keyboardSize.height
        guard
          height > 0,
          let buttonBottomDistance = self.buttonBottomDistance
        else { return }
        buttonBottomDistance.constant = -10 - height
        view.layoutIfNeeded()
      }
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    buttonBottomDistance?.constant = -30
    view.layoutIfNeeded()
  }
}
