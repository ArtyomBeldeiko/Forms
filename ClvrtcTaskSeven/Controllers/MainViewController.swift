//
//  MainViewController.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 24.01.23.
//

import UIKit

class MainViewController: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var form: Form?
    var clevertecImage: UIImage?
    var textualFieldValue: String?
    var numericalFieldValue: String?
    var listFieldValue: String? 
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        FormFieldType.registerCells(for: tableView)
        tableView.register(TableViewFooter.self, forHeaderFooterViewReuseIdentifier: TableViewFooter.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFormData()
        setupViews()
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
        
    private func configureTableView() {
        tableView.backgroundColor = .clear
    }
        
    private func setupViews() {
        configureTableView()
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let imageViewContraints = [
            imageView.widthAnchor.constraint(equalToConstant: screenSize.width - 40),
            imageView.heightAnchor.constraint(equalToConstant: screenSize.height / 4),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ]
        
        let tableViewContraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.widthAnchor.constraint(equalToConstant: screenSize.width - 40),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
                
        NSLayoutConstraint.activate(imageViewContraints)
        NSLayoutConstraint.activate(tableViewContraints)
    }
    
    private func fetchFormData() {
        NetworkManager.shared.getForm { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.form = data
                
                DispatchQueue.main.async {
                    self.title = self.form?.title
                    self.tableView.reloadData()
                }
                
                guard let image = self.form?.image else { return }
                
                NetworkManager.shared.downloadImage(with: image) { image in
                    guard let image = image else { return }
                    self.imageView.image = image
                    self.clevertecImage = image
                }
                
            case .failure(_):
                print("Failed to fetch data.")
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form?.fields.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = form?.fields[indexPath.row]
        
        let cell: UITableViewCell
        
        if let formFieldType = form?.fields[indexPath.row].fieldType {
            cell = formFieldType.dequeueCell(for: tableView, at: indexPath)
        } else {
            cell = UITableViewCell()
        }
        
        if let updatableCell = cell as? FieldUpdatable {
            updatableCell.update(with: field!)
        }
        
        if let updatableCell = cell as? FormValuableTableViewCell {
            updatableCell.delegate = self
        }
        
        if let updatableCell = cell as? FormTextualTableViewCell {
            updatableCell.delegate = self
        }
        
        if let updatableCell = cell as? FormNumericTableViewCell {
            updatableCell.delegate = self
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewFooter.identifier)
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: FormValuableTableViewCellDelegate {
    func presentValueSelectionVC(with cell: FormValuableTableViewCell) {
        let valueSelectionVC = ValueSelectionViewController()
        
        valueSelectionVC.values = cell.values
        valueSelectionVC.imageView.image = clevertecImage
        valueSelectionVC.completionHandler = { value in
            if value == "Не выбрано" {
                self.listFieldValue = "none"
            } else if value == "Первое значение" {
                self.listFieldValue = "v1"
            } else if value == "Второе значение" {
                self.listFieldValue = "v2"
            } else if value == "Третье значение" {
                self.listFieldValue = "v3"
            }
        }

        navigationController?.present(valueSelectionVC, animated: true)
    }
}

extension MainViewController: FormTextualTableViewCellDelegate {
    func textFieldEditingChange(in tableViewCell: FormTextualTableViewCell, textEditingChange: String?) {
        guard let textualValue = tableViewCell.textField.text else { return }
        
        let isValidValue = validateTextualField(with: textualValue)
        
        if isValidValue == false {
            textualFieldValue = ""
        } else {
            textualFieldValue = textualValue
        }
    }
}

extension MainViewController: FormNumericTableViewCelllDelegate {
    func textFieldDidEndEditing(in tableViewCell: FormNumericTableViewCell, textEditingDidEnd: String?) {
        guard let numericalValue = tableViewCell.textField.text else { return }
        
        let isValidValue = validateNumericField(with: numericalValue)
        
        if isValidValue == false {
            print("Incorrect")
        } else {
            if numericalValue.contains(",") {
                numericalFieldValue = String(numericalValue.doubleValue)
            } else {
                numericalFieldValue = numericalValue
            }
            print(numericalFieldValue)
        }
        
    }
}

