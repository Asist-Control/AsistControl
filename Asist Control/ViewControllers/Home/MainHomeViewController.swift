//
//  MainHomeViewController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 2/18/23.
//

import UIKit

class MainHomeViewController: HomeViewController {

  private let controller = MainHomeController()

  private let viewTitle: UILabel = {
    let label = UILabel()
    label.font = .h3
    label.textColor = .primaryLabel
    label.numberOfLines = 0
    label.textAlignment = .center
    label.enableAutolayout()
    
    return label
  }()

  private let contentView: UIView = {
    let view = UIView()
    view.enableAutolayout()
    return view
  }()

  private let trucksView = HomeCellItem()
  private let employeesView = HomeCellItem()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupSubviews()
    setupConstraints()
    setupTitleTextWithDate()
    configureViews()
  }

  private func setupSubviews() {
    view.addSubview(viewTitle)
    view.addSubview(contentView)

    contentView.addSubview(trucksView)
    contentView.addSubview(employeesView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      viewTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      viewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

      contentView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 10),
      contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),

      trucksView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      trucksView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      trucksView.heightAnchor.constraint(equalTo: trucksView.widthAnchor),

      employeesView.leadingAnchor.constraint(equalTo: trucksView.trailingAnchor, constant: 10),
      employeesView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      employeesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      employeesView.widthAnchor.constraint(equalTo: trucksView.widthAnchor),
      employeesView.heightAnchor.constraint(equalTo: employeesView.widthAnchor)
    ])
  }

  private func configureViews() {
    controller.getTrucksCount { count in
      self.trucksView.configure(with: "Camiones", and: count)
      self.employeesView.configure(with: "Empleados", and: count * 3)
    }
  }

  private func setupTitleTextWithDate() {
    viewTitle.text = Current.Today().stringDate
  }
}
