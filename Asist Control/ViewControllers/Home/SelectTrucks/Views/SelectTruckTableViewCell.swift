//
//  SelectTruckTableViewCell.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/15/22.
//

import UIKit

class SelectTruckTableViewCell: UITableViewCell {
    
    static let identifier = "SelectTruckTableViewCellIdentifier"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .h3Medium
        label.textColor = .primaryLabel
        label.enableAutolayout()
        
        return label
    }()
    
    private let selectedBadge: UIImageView = {
        let iv = UIImageView()
      iv.image = .checkmarkCircleFill
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .successGreen
        iv.enableAutolayout()
        
        return iv
    }()
    
    func configure(with truck: Truck) {
        titleLabel.text = "Camión \(truck.id)"
        
        setupSubviews()
        setupConstraints()
        
        selectedBadge.isHidden = !truck.isSelected
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = .background
    }
    
    private func setupSubviews() {
        backgroundColor = .background
        
        addSubview(titleLabel)
        addSubview(selectedBadge)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            selectedBadge.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            selectedBadge.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            selectedBadge.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectedBadge.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
