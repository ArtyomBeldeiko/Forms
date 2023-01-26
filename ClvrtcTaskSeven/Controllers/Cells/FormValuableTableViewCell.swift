//
//  FormValuableTableViewCell.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 25.01.23.
//

import UIKit

class FormValuableTableViewCell: UITableViewCell {

    static let identifier = "FormValuableTableViewCell"
        
    lazy var valueSelectionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Выберите значение", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(valueSelectionButton)
        valueSelectionButton.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
