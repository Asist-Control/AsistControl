//
//  LoginViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/1/22.
//

import UIKit

class LoginViewController: UIViewController, LoginDelegate {

    // MARK: - Properties
    private let margin = CGFloat(30)
    private let smallSpacing = CGFloat(10)
    private let spacing = CGFloat(20)
    private let labelHeight = CGFloat(35)
    private let buttonHeight = CGFloat(60)
    private lazy var marginTop: CGFloat = {
        if view.bounds.height > 700 {
            return 130
        } else {
            return 80
        }
    }()
    
    var controller = LoginController()
    
    // MARK: - Subviews
    private let welcomeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = K.Login.loginTitle
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .h1
        label.textColor = .primaryLabel
        label.enableAutolayout()
        return label
    }()
    
    private let createAccountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = K.Login.enterData
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .h2Light
        label.textColor = .primaryLabel
        label.enableAutolayout()
        return label
    }()
    
    private let emailTextField: TextInputView = {
        let field = TextInputView(frame: .zero)
        field.configure(withStyle: .email, title: K.SignUp.emailLabel)
        field.enableAutolayout()
        return field
    }()
    
    private let passwordTextField: TextInputView = {
        let field = TextInputView(frame: .zero)
        field.configure(withStyle: .password, title: K.SignUp.passLabel)
        field.enableAutolayout()
        return field
    }()
    
    var buttonConstraint: NSLayoutConstraint?
    
    private let logInButton: ACButton = {
        let button = ACButton(frame: .zero)
        button.title = K.Login.loginButton
        button.enableAutolayout()
        return button
    }()
    
    private let forgotPasswordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = K.Login.forgotPassword
        label.font = .body2Light
        label.textColor = .primaryLabel
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.enableAutolayout()
        return label
    }()
    
    private let changePassword: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(K.Login.changePassword, for: .normal)
        button.setTitleColor(.primaryLabel, for: .normal)
        button.titleLabel?.font = .body2Bold
        button.titleLabel?.textAlignment = .right
        button.backgroundColor = .clear
        button.enableAutolayout()
        return button
    }()
    
    private let forgotPasswordContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.enableAutolayout()
        return view
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        setupActions()
        
        controller.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Setups
    private func setupSubviews() {
        view.backgroundColor = .background
        
        view.addSubview(welcomeLabel)
        view.addSubview(createAccountLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        view.addSubview(forgotPasswordContainer)
    }
    
    private func setupActions() {
        changePassword.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: marginTop),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            welcomeLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            createAccountLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: spacing),
            createAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            createAccountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            createAccountLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            emailTextField.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: marginTop / 2),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            emailTextField.heightAnchor.constraint(equalToConstant: TextInputView.height),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: spacing),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            passwordTextField.heightAnchor.constraint(equalToConstant: TextInputView.height),
            
            forgotPasswordContainer.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: smallSpacing),
            forgotPasswordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin * 3),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin * 3),
            logInButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
        buttonConstraint = logInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin * 2)
        buttonConstraint?.isActive = true
    }
    
    // MARK: - Selectors
    @objc private func goToSignUp() {
        
    }
    
    @objc private func logInButtonPressed() {
        guard
            let email = emailTextField.currentText, !email.isEmpty,
            let pass = passwordTextField.currentText, !pass.isEmpty
        else { return }
        logInButton.startLoading()
        controller.logIn(email: email, password: pass)
    }
    
    @objc private func dismissKeyboard() {
        emailTextField.deselctTextField()
        passwordTextField.deselctTextField()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                let height = keyboardSize.height
                guard height > 0 else { return }
                self.buttonConstraint?.constant = -10 - height
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        buttonConstraint?.constant = -30
        self.view.layoutIfNeeded()
    }
    
    func loginWasSuccessful() {
        logInButton.stopLoading()
        let homeVC = AllTrucksListViewController()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func loginFailed(with error: Error) {
        logInButton.stopLoading()
        errorLogingIn(with: error.localizedDescription)
    }
    
    func errorLogingIn(with errorMessage: String) {
        let alert = UIAlertController(title: "Error logging in", message: "\(errorMessage) Try again!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }

}
