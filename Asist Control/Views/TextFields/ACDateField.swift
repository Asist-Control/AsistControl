//
//  ACDateField.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 7/18/22.
//

import UIKit

class ACDateField: UIView {
    
    // MARK: - Properties
    static let height = CGFloat(80)
    
    private let cornerRadius = CGFloat(10)
    private let leftPadding = CGFloat(10)
    
    private let textFieldHeight = CGFloat(50)
    private let labelHeight = CGFloat(20)
    private let spacing = CGFloat(10)
    
    var currentText: String? {
        get {
            return textField.text
        }
    }

    // MARK: - Subviews
    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .body2Bold
        label.textColor = .primaryLabel
        label.textAlignment = .left
        label.enableAutolayout()
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.maximumDate = Date()
        picker.enableAutolayout()
        
        return picker
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField(frame: .zero)
        field.textColor = .primaryLabel
        field.backgroundColor = .inputBackground
        field.layer.cornerRadius = cornerRadius
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.setLeftPaddingPoints(leftPadding)
        field.setRightPaddingPoints(textFieldHeight)
        field.enableAutolayout()
        return field
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.tintColor = .primaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.enableAutolayout()
        return imageView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupConstraints()
    }
    
    func configure(withTitle title: String) {
        label.text = title
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        textField.inputView = datePicker
        textField.text = formatDate(date: Date())
        
        icon.image = UIImage(systemName: "calendar")
    }
    
    // MARK: - Setups
    private func setupSubviews() {
        [label, textField].forEach { addSubview($0) }
        textField.addSubview(icon)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: labelHeight),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: spacing),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            icon.topAnchor.constraint(equalTo: textField.topAnchor, constant: spacing),
            icon.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            icon.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -spacing),
            icon.widthAnchor.constraint(equalTo: textField.heightAnchor)
        ])
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    @objc private func dateChanged(sender datePicker: UIDatePicker) {
        textField.text = formatDate(date: datePicker.date)
    }
    
}
