//
//  ACDropDown.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 7/18/22.
//

import UIKit
import DropDown

class ACDropDown: UIView {

    private let dropDown = DropDown()
    
    private let buttonHeight = CGFloat(50)
    private let labelHeight = CGFloat(20)
    
    public var text: String {
        get {
            return dropDownButton.titleLabel?.text ?? ""
        }
    }
    
    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .body2Bold
        label.textColor = .primaryLabel
        label.textAlignment = .left
        label.enableAutolayout()
        return label
    }()
    
    private let dropDownButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .inputBackground
        button.setTitleColor(.primaryLabel, for: .normal)
        button.contentHorizontalAlignment = .left
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.enableAutolayout()
        
        return button
    }()
    
    func configure(withTitle title: String, with datasource: [String]) {
        dropDown.dataSource = datasource
        label.text = title
        dropDownButton.setTitle(datasource.count > 0 ? datasource[0] : title, for: .normal)
        
        setupSubviews()
        setupConstraints()
        setupDropdowns()
    }
    
    private func setupSubviews() {
        addSubview(label)
        addSubview(dropDownButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: labelHeight),
            
            dropDownButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            dropDownButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            dropDownButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            dropDownButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            dropDownButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupDropdowns() {
        dropDownButton.addTarget(self, action: #selector(dropDownWasTapped), for: .touchUpInside)
        dropDown.anchorView = dropDownButton.self
        dropDown.bottomOffset = CGPoint(x: 0, y: dropDownButton.frame.size.height)
        dropDown.selectionAction = { [weak self] index, item in
            guard let self = self else { return }
            self.dropDownButton.setTitle(item, for: .normal)
        }
    }
    
    @objc private func dropDownWasTapped() {
        dropDown.show()
    }
    
}
