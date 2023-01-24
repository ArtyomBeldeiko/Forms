//
//  MainViewController.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 24.01.23.
//

import UIKit

class MainViewController: UIViewController {

    let screenSize: CGRect = UIScreen.main.bounds
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        
        title = "ADSADAS"
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sendButton.layer.cornerRadius = 16
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
    }
    
    private func configureSendButton() {
        sendButton.backgroundColor = .red
        sendButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        sendButton.setTitle("Отправить", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
    }
    
    private func setupViews() {
        configureTableView()
        configureSendButton()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(imageView)
        view.addSubview(sendButton)
    }
    
    private func setupConstraints() {
        let tableViewContraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.widthAnchor.constraint(equalToConstant: screenSize.width - 40),
            tableView.heightAnchor.constraint(equalToConstant: screenSize.height / 2),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let imageViewContraints = [
            imageView.widthAnchor.constraint(equalToConstant: screenSize.width - 40),
            imageView.heightAnchor.constraint(equalToConstant: screenSize.height / 4),
            imageView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -8),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let sendButtonContraints = [
            sendButton.widthAnchor.constraint(equalToConstant: screenSize.width / 1.4),
            sendButton.heightAnchor.constraint(equalToConstant: 45),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45)
        ]
        
        NSLayoutConstraint.activate(tableViewContraints)
        NSLayoutConstraint.activate(imageViewContraints)
        NSLayoutConstraint.activate(sendButtonContraints)
    }
    
}
