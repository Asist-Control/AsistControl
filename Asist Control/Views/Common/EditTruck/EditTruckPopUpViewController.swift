//
//  EditTruckPopUpViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 9/23/22.
//

import UIKit

class EditTruckPopUpViewController: UIViewController {

  private let editTruckView = EditTruckView()
  var truck: Truck?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupSubviews()
    setupConstraints()
    configureView()
  }

  private func setupSubviews() {
    modalPresentationStyle = .overFullScreen
    modalTransitionStyle = .crossDissolve
    view.backgroundColor = .clear
    view.addSubview(editTruckView)
    editTruckView.backgroundColor = .background
    editTruckView.enableAutolayout()
  }

  private func setupConstraints() {
    let screenWidth = UIScreen.main.bounds.width
    NSLayoutConstraint.activate([
      editTruckView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      editTruckView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      editTruckView.widthAnchor.constraint(equalToConstant: screenWidth - 40),
      editTruckView.heightAnchor.constraint(equalToConstant: screenWidth - 40)
    ])
  }

  func configureView() {
    guard let truck = truck else { return }
    editTruckView.configure(with: truck, for: view)
  }
    
}
