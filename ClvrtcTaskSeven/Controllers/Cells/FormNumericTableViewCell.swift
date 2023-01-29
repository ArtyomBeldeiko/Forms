//
//  FormNumericTableViewCell.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 25.01.23.
//

import UIKit

protocol FormNumericTableViewCelllDelegate {
    func textFieldDidEndEditing(in tableViewCell: FormNumericTableViewCell, textEditingDidEnd: String?)
    func textFieldShouldReturn (in tableViewCell: FormNumericTableViewCell)
}

class FormNumericTableViewCell: UITableViewCell, FieldConformity {
    
    static let identifier = "FormNumericTableViewCell"
    
    var delegate: FormNumericTableViewCelllDelegate?
    var field: Field?
    
    lazy var titleLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16, weight: .medium)
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numbersAndPunctuation
        textField.addTarget(self, action: #selector(textEditingDidEnd(_:)), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLable)
        contentView.addSubview(textField)
    }
    
    private func setConstraints() {
        let titleLabelContraints = [
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLable.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor)
        ]
        
        let textFieldContraint = [
            textField.leadingAnchor.constraint(equalTo: titleLable.trailingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
    
        NSLayoutConstraint.activate(titleLabelContraints)
        NSLayoutConstraint.activate(textFieldContraint)
    }
    
    @objc private func textEditingDidEnd(_ sender: UITextField) {
        delegate?.textFieldDidEndEditing(in: self, textEditingDidEnd: sender.text)
    }
    
    @objc private func textFieldShouldReturn(_ sender: UITextField) {
        delegate?.textFieldShouldReturn(in: self)
    }
}

extension FormNumericTableViewCell: FieldUpdatable {
    func update(with field: Field) {
        self.field = field
        
        titleLable.text = field.title
    }
}

