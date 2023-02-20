//
//  InitialViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/1/22.
//

import UIKit
import FirebaseAuth

class InitialViewController: UIViewController {
  
  private let logo: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "logo_clear")
    imageView.contentMode = .scaleAspectFit
    imageView.enableAutolayout()
    
    return imageView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .background
    
    setupSubviews()
    setupConstraints()
    
    performAnimation()
  }
  
  private func setupSubviews() {
    
    view.addSubview(logo)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      
      logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      logo.widthAnchor.constraint(equalToConstant: 200),
      logo.heightAnchor.constraint(equalToConstant: 200),
    ])
  }
  
  private func performAnimation() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
      self?.goToLoginOrHomeScreen()
    }
  }
  
  private func goToLoginOrHomeScreen() {
    guard let userID = FirebaseService.shared.auth.currentUser?.uid else {
      goToLogin()
      return
    }
    goToHomeScreen(for: userID)
  }

  private func goToLogin() {
    let login = LoginViewController()
    login.modalPresentationStyle = .fullScreen
    login.modalTransitionStyle = .crossDissolve
    present(login, animated: true)
  }

  private func goToHomeScreen(for userID: String) {
    FirebaseService.shared.trucksWereSelectedToday { trucksSelected in
      let homeVC = trucksSelected ? MainHomeViewController() : HomeTrucksListViewController()
      let nav = UINavigationController(rootViewController: homeVC)
      nav.modalPresentationStyle = .fullScreen
      nav.modalTransitionStyle = .crossDissolve
      FirebaseService.shared.getUser(with: userID, completion: { [weak self] user in
        guard let self = self else { return }
        Current.shared.user = user
        self.present(nav, animated: true)
      })
    }
  }
}
