//
//  HomeCellItem.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 2/20/23.
//

import UIKit

class HomeCellItem: UIView {
  
  private let title: UILabel = {
    let label = UILabel()
    label.font = .h3
    label.textAlignment = .center
    label.enableAutolayout()
    return label
  }()
  
  private let numberLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 60, weight: .bold)
    label.textAlignment = .center
    label.enableAutolayout()
    return label
  }()
  
  private let activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.hidesWhenStopped = true
    indicator.enableAutolayout()
    return indicator
  }()
  
  convenience init() {
    self.init(frame: .zero)
    
    backgroundColor = .asistLightblue
    setupSubviews()
    setupConstraints()
    activityIndicator.startAnimating()
    enableAutolayout()
  }
  
  private func setupSubviews() {
    addSubview(activityIndicator)
    addSubview(title)
    addSubview(numberLabel)
    
    layer.cornerRadius = 20
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
      title.heightAnchor.constraint(equalToConstant: 30),
      
      numberLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
      numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
      numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
      
      activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  func configure(with title: String, and value: Int) {
    activityIndicator.stopAnimating()
    self.title.text = title
    numberLabel.text = "\(value)"
  }
}
