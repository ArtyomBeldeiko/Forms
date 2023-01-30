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
    
    lazy var activityIndicatorContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFormData()
        setupViews()
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        activityIndicator.center = view.center
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
    }
    
    private func setupViews() {
        configureTableView()
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(tableView)
        
        presentActivityIndicator()
    }
    
    private func presentActivityIndicator() {
        view.addSubview(activityIndicatorContainer)
        activityIndicatorContainer.frame = view.bounds
        activityIndicatorContainer.addSubview(activityIndicator)
        activityIndicator.startAnimating()
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
                
                NetworkManager.shared.downloadImage(with: image) { [weak self] image in
                    
                    guard let self = self else { return }
                    
                    guard let image = image else { return }
                    self.imageView.image = image
                    self.clevertecImage = image
                    
                    DispatchQueue.main.async {
                        self.activityIndicatorContainer.isHidden = true
                        self.activityIndicator.stopAnimating()
                    }
                }
                
            case .failure(_):
                print("Failed to fetch data.")
            }
        }
    }
    
    //    MARK: - UIAlerts
    
    private func showTextualValueErrorAlert() {
        let textualValueErrorAlert = UIAlertController(title: "Ошибка текстового поля", message: "Допускаются только буквы латинского и кириллического алфавита, а также цифры", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Закрыть", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            self.textualFieldValue = nil
            self.dismiss(animated: true)
        }
        
        textualValueErrorAlert.addAction(okAction)
        
        self.present(textualValueErrorAlert, animated: true)
    }
    
    private func showNumericalValueErrorAlert() {
        let numericalValueErrorAlert = UIAlertController(title: "Ошибка числового поля", message: "Допускаются только цифры", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Закрыть", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            self.numericalFieldValue = nil
            self.dismiss(animated: true)
        }
        
        numericalValueErrorAlert.addAction(okAction)
        
        self.present(numericalValueErrorAlert, animated: true)
    }
    
    private func showListValueErrorAlert() {
        let listValueErrorAlert = UIAlertController(title: "Ошибка поля выбора значения", message: "Выберите значение", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Закрыть", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            self.listFieldValue = nil
            self.dismiss(animated: true)
        }
        
        listValueErrorAlert.addAction(okAction)
        
        self.present(listValueErrorAlert, animated: true)
    }
    
    private func showResultAlert(from responseResult: String) {
        let resultAlert = UIAlertController(title: nil, message: responseResult, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Закрыть", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            self.dismiss(animated: true)
        }
        
        resultAlert.addAction(okAction)
        
        self.present(resultAlert, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form?.fields.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = form?.fields[indexPath.row]
        
        let cell: UITableViewCell
        
        if let formFieldType = form?.fields[indexPath.row].fieldType {
            cell = formFieldType.dequeueCell(for: tableView, at: indexPath)
            cell.selectionStyle = .none
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
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewFooter.identifier) as! TableViewFooter
        
        footer.delegate = self
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - FormValuableTableViewCellDelegate

extension MainViewController: FormValuableTableViewCellDelegate {
    func presentValueSelectionVC(with cell: FormValuableTableViewCell) {
        let valueSelectionVC = ValueSelectionViewController()
        
        valueSelectionVC.values = cell.values
        valueSelectionVC.imageView.image = clevertecImage
        valueSelectionVC.completionHandler = { [weak self] value in
            guard let self = self else { return }
            
            if value == "Не выбрано" {
                self.showListValueErrorAlert()
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

// MARK: - FormTextualTableViewCellDelegate

extension MainViewController: FormTextualTableViewCellDelegate {
    func textFieldShouldReturn(in tableViewCell: FormTextualTableViewCell) {
        self.view.endEditing(true)
    }
    
    func textFieldEditingChange(in tableViewCell: FormTextualTableViewCell, textEditingChange: String?) {
        guard let textualValue = tableViewCell.textField.text else { return }
        
        let isValidValue = validateTextualField(with: textualValue)
        
        if isValidValue == false {
            textualFieldValue = ""
            showTextualValueErrorAlert()
        } else {
            textualFieldValue = textualValue
        }
    }
}

// MARK: - FormNumericTableViewCelllDelegate

extension MainViewController: FormNumericTableViewCelllDelegate {
    func textFieldShouldReturn(in tableViewCell: FormNumericTableViewCell) {
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(in tableViewCell: FormNumericTableViewCell, textEditingDidEnd: String?) {
        guard let numericalValue = tableViewCell.textField.text else { return }
        
        let isValidValue = validateNumericField(with: numericalValue)
        
        if isValidValue == false {
            showNumericalValueErrorAlert()
        } else {
            if numericalValue.contains(",") {
                numericalFieldValue = String(numericalValue.doubleValue)
            } else {
                numericalFieldValue = numericalValue
            }
        }
    }
}

// MARK: - TableViewFooterDelegate

extension MainViewController: TableViewFooterDelegate {
    func sendButtonTapped(in headerFooterView: TableViewFooter) {
        guard let textualFieldValue = textualFieldValue else {
            showTextualValueErrorAlert()
            return
        }
        
        guard let numericalFieldValue = numericalFieldValue else {
            showNumericalValueErrorAlert()
            return
        }
        
        guard let listFieldValue = listFieldValue else {
            showListValueErrorAlert()
            return
        }
        
        activityIndicator.startAnimating()
        activityIndicatorContainer.isHidden = false
        
        NetworkManager.shared.sendFieldData(textualField: textualFieldValue, numericalField: numericalFieldValue, listValue: listFieldValue) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let responseResult):
                
                DispatchQueue.main.async {
                    self.activityIndicatorContainer.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.showResultAlert(from: responseResult.result)
                }
                
            case .failure(_):
                print("Response failure")
            }
        }
    }
}

