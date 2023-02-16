//
//  GenericHeaderView.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 9/28/22.
//

import UIKit

class GenericHeaderView: UIView {

  private var parent: UIView?
  private var action: (() -> Void)?

  private let dismissImageSize: CGFloat = 30

  private let dismissImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    image.image = .multiply
    image.tintColor = .white
    image.isUserInteractionEnabled = true
    image.enableAutolayout()
    
    return image
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .h2
    label.text = "Camión"
    label.textColor = .white
    label.textAlignment = .center
    label.backgroundColor = .clear
    label.enableAutolayout()
    
    return label
  }()

  func configure(for parent: UIView, with title: String?, action: (() -> Void)?) {
    self.parent = parent
    self.action = action
    titleLabel.text = title
    backgroundColor = .asistDarkBlue
    layer.cornerRadius = 20
    layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    enableAutolayout()

    setupSubviews()
    setupConstraints()
    setupDismissAction()
  }

  private func setupSubviews() {
    addSubview(titleLabel)
    addSubview(dismissImage)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      dismissImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      dismissImage.centerYAnchor.constraint(equalTo: centerYAnchor),
      dismissImage.widthAnchor.constraint(equalToConstant: dismissImageSize),
      dismissImage.heightAnchor.constraint(equalToConstant: dismissImageSize),
      
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
      titleLabel.heightAnchor.constraint(equalToConstant: 44)
    ])
  }

  private func setupDismissAction() {
    let tapAction = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
    dismissImage.addGestureRecognizer(tapAction)
  }
  
  @objc private func dismissPopUp() {
    parent?.removeFromSuperview()
    action?()
  }

}
