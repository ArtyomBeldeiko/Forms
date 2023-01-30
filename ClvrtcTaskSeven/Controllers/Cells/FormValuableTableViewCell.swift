//
//  FormValuableTableViewCell.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 25.01.23.
//

import UIKit

protocol FormValuableTableViewCellDelegate {
    func presentValueSelectionVC(with cell: FormValuableTableViewCell)
}

class FormValuableTableViewCell: UITableViewCell, FieldConformity {
    
    static let identifier = "FormValuableTableViewCell"
    
    var delegate: FormValuableTableViewCellDelegate?
    var field: Field?
    var values = [String]()
    
    private lazy var valueSelectionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 86 / 255, green: 81 / 255, blue: 139 / 255, alpha: 0.92)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(valueSelectionButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(valueSelectionButton)
        setConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        valueSelectionButton.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        let valueSelectionButtonConstraints = [
            valueSelectionButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            valueSelectionButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -8),
            valueSelectionButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            valueSelectionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(valueSelectionButtonConstraints)
    }
    
    @objc private func valueSelectionButtonTapped() {
        delegate?.presentValueSelectionVC(with: self)
    }
}

// MARK: - FieldUpdatable

extension FormValuableTableViewCell: FieldUpdatable {
    func update(with field: Field) {
        self.field = field
        
        valueSelectionButton.setTitle(field.title, for: .normal)
        
        guard let noneValue = field.values?.none, let firstValue = field.values?.v1, let secondValue = field.values?.v2, let thirdValue = field.values?.v3 else { return }
        
        values.insert(noneValue, at: 0)
        values.insert(firstValue, at: 1)
        values.insert(secondValue, at: 2)
        values.insert(thirdValue, at: 3)
    }
}

