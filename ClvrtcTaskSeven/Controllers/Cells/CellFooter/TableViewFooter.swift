//
//  TableViewFooter.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 27.01.23.
//

import UIKit

class TableViewFooter: UITableViewHeaderFooterView {

    static let identifier = "TableViewFooter"
    
    let screenSize: CGRect = UIScreen.main.bounds
        
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 240 / 255, green: 84 / 255, blue: 87 / 255, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(sendButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sendButton.layer.cornerRadius = 16
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        let sendButtonConstraints = [
            sendButton.widthAnchor.constraint(equalToConstant: screenSize.width / 1.4),
            sendButton.heightAnchor.constraint(equalToConstant: 45),
            sendButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            sendButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]

        NSLayoutConstraint.activate(sendButtonConstraints)
    }
}
