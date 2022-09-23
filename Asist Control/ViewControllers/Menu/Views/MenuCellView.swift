//
//  MenuCellView.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 6/12/22.
//

import UIKit

class MenuCellView: UIView {
    
    typealias Action = () -> Void

    private let container: UIView = {
        let view = UIView()
        view.enableAutolayout()
        
        return view
    }()
    
    private let icon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.enableAutolayout()
        
        return iv
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .h3
        label.textColor = .primaryLabel
        label.enableAutolayout()
        
        return label
    }()
    
    private let subtitle: UILabel = {
        let label = UILabel()
        label.font = .captionLight
        label.textColor = .primaryLabel
        label.enableAutolayout()
        
        return label
    }()
    
    private let rightArrow: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "chevron.forward")
        iv.enableAutolayout()
        
        return iv
    }()
    
    private var action: Action?
    
    init(title: String, subtitle: String, icon: UIImage?, action: @escaping Action) {
        super.init(frame: .zero)
        
        self.title.text = title
        self.subtitle.text = subtitle
        self.icon.image = icon
        self.action = action
        
        isUserInteractionEnabled = true
        
        setupSubviews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(container)
        
        container.addSubview(icon)
        container.addSubview(title)
        container.addSubview(subtitle)
        container.addSubview(rightArrow)
        
        addBottomBorder(with: .gray, andWidth: 0.5)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            icon.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            icon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5),
            icon.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5),
            icon.widthAnchor.constraint(equalToConstant: 40),
            
            title.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 15),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            subtitle.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 15),
            subtitle.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            
            rightArrow.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            rightArrow.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 15),
            rightArrow.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            rightArrow.widthAnchor.constraint(equalToConstant: 25),
            rightArrow.heightAnchor.constraint(equalToConstant: 25),
            
            subtitle.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: 15)
        ])
    }
    
    private func setupActions() {
        container.isUserInteractionEnabled = true
        
//        let tap = UIGestureRecognizer(target: self, action: #selector(performAction))
//        addGestureRecognizer(tap)
    }
    
    private func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    private func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectView()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        deselectView()
        action?()
    }
    
    private func selectView() {
        backgroundColor = .lightGray
    }
    
    private func deselectView() {
        backgroundColor = .clear
    }
}
