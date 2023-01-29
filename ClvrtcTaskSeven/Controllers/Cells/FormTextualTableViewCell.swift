//
//  FormTextualTableViewCell.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 25.01.23.
//

import UIKit

protocol FormTextualTableViewCellDelegate {
    func textFieldEditingChange(in tableViewCell: FormTextualTableViewCell, textEditingChange: String?)
}

class FormTextualTableViewCell: UITableViewCell, FieldConformity {
    
    static let identifier = "FormTextualTableViewCell"
    
    var delegate: FormTextualTableViewCellDelegate?
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
        textField.addTarget(self, action: #selector(textEditingChange(_:)), for: .editingChanged)
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
    
    @objc private func textEditingChange(_ sender: UITextField) {
        delegate?.textFieldEditingChange(in: self, textEditingChange: sender.text)
    }
}

extension FormTextualTableViewCell: FieldUpdatable {
    func update(with field: Field) {
        self.field = field
        
        titleLable.text = field.title
    }
}

