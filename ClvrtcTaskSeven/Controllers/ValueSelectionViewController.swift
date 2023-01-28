//
//  ValueSelectionViewController.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 28.01.23.
//

import UIKit

class ValueSelectionViewController: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var values = [String]()
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    private let valuePicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
        
        valuePicker.delegate = self
        valuePicker.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        confirmButton.layer.cornerRadius = 12
    }
    
    private func setViews() {
        view.backgroundColor = .white
        
        setupConfirmButton()
        
        view.addSubview(imageView)
        view.addSubview(valuePicker)
        view.addSubview(confirmButton)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConfirmButton() {
        confirmButton.backgroundColor = UIColor(red: 240 / 255, green: 84 / 255, blue: 87 / 255, alpha: 1)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.setTitle("Выбрать", for: .normal)
        confirmButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    private func setConstraints() {
                
        let imageViewContraints = [
            imageView.widthAnchor.constraint(equalToConstant: screenSize.width - 40),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: screenSize.height / 4),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let valuePickerContraints = [
            valuePicker.widthAnchor.constraint(equalToConstant: screenSize.width / 1.4),
            valuePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            valuePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let confirmButtonContraints = [
            confirmButton.widthAnchor.constraint(equalToConstant: screenSize.width / 1.4),
            confirmButton.heightAnchor.constraint(equalToConstant: 45),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ]

        NSLayoutConstraint.activate(valuePickerContraints)
        NSLayoutConstraint.activate(confirmButtonContraints)
        NSLayoutConstraint.activate(imageViewContraints)
    }
}

extension ValueSelectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let valueTitle = values[row]
        return valueTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}

