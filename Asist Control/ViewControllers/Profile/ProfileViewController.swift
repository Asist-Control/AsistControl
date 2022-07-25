//
//  ProfileViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/8/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "person.circle.fill")
        iv.image?.withTintColor(.primary)
        iv.enableAutolayout()
        
        return iv
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .h1
        label.textColor = .primaryLabel
        label.textAlignment = .center
        label.enableAutolayout()
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .h3Medium
        label.textColor = .primaryLabel
        label.textAlignment = .center
        label.enableAutolayout()
        
        return label
    }()
    
    private let adminTitle: UILabel = {
        let label = UILabel()
        label.text = "Admin"
        label.font = .h3Regular
        label.textAlignment = .center
        label.enableAutolayout()
        
        return label
    }()
    
    private let menuTableView: UITableView = {
        let tv = UITableView()
        tv.enableAutolayout()
        
        return tv
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cerrar sesión", for: .normal)
        button.setTitleColor(.background, for: .normal)
        button.backgroundColor = .red
        button.enableAutolayout()
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        
        setupSubviews()
        setupConstraints()
        
        nameLabel.text = Current.shared.user?.fullName
        subtitleLabel.text = Current.shared.user?.email
    }
    
    private func setupSubviews() {
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(adminTitle)
        adminTitle.isHidden = !(Current.shared.user?.userType == .admin)
        
        view.addSubview(signOutButton)
        signOutButton.layer.cornerRadius = 20
        signOutButton.addTarget(self, action: #selector(signOutConfirmation), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            profileImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            profileImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            adminTitle.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            adminTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            adminTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            signOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signOutButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    @objc private func signOutConfirmation() {
        let alert = UIAlertController(title: "Cerrar sesión", message: "¿Esta seguro de que desea cerrar sesión?", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Cerrar sesión", style: .destructive) { _ in
            self.signOut()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func signOut() {
        do {
            try FirebaseService.shared.auth.signOut()
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .coverVertical
            present(loginVC, animated: true)
        } catch (let err) {
            print("There was an error logging out: \(err.localizedDescription)")
        }
    }
    
}
