//
//  HomeViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/1/22.
//

import UIKit

class HomeViewController: UIViewController {
        
  private var titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = .h1Light
    label.textColor = .primaryLabel
    label.enableAutolayout()
    
    return label
  }()
  
  private var trucks: [Truck] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSubviews()
    setupConstraints()

    view.backgroundColor = .background
    title = "Inicio"
    navigationController?.navigationBar.topItem?.titleView?.tintColor = .primaryLabel
    
    let profileIcon = UIBarButtonItem(image: .personCircleFill, style: .plain, target: self, action: #selector(openProfileView))
    profileIcon.tintColor = .primary
    navigationController?.navigationBar.topItem?.rightBarButtonItem = profileIcon
    
    let menuIcon = UIBarButtonItem(image: .line3Horizontal, style: .plain, target: self, action: #selector(openMenuView))
    menuIcon.tintColor = .primary
    navigationController?.navigationBar.topItem?.leftBarButtonItem = menuIcon
  }
  
  private func setupSubviews() {
    view.addSubview(titleLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
    ])
  }
  
  @objc private func openProfileView() {
    let profileVC = ProfileViewController()
    profileVC.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(profileVC, animated: true)
  }
  
  @objc private func openMenuView() {
    let menuVC = MenuViewController()
    let nav = UINavigationController(rootViewController: menuVC)
    nav.modalPresentationStyle = .fullScreen
    present(nav, animated: true)
  }

}
