//
//  ConvertViewController.swift
//  CurrencyConverter
//
//  Created by Kudryatzhan Arziyev on 1/2/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties of views programmatically
    var baseCurrencyButton = UIButton(type: .system)
    var baseCurrencyTextField = UITextField()
    var baseStackView = UIStackView()
    var convertCurrencyButton = UIButton(type: .system)
    var convertCurrencyTextField = UITextField()
    var convertStackView = UIStackView()
    var overallStackView = UIStackView()
    var currenciesPickerView = UIPickerView()
    
    
    // MARK: - Properties
    var currencyValues: CurrencyValues? {
        didSet {
            DispatchQueue.main.async {
                self.viewDidLoad()
            }
            
        }
    }
    var currenciesDictionary: [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.3568627451, green: 0.6235294118, blue: 0.7960784314, alpha: 1)
        
        currenciesPickerView.dataSource = self
        currenciesPickerView.delegate = self
        baseCurrencyTextField.delegate = self
        convertCurrencyTextField.delegate = self
        
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Set up views and constraints methods
    func setupViews() {
        
        // base currency button
        baseCurrencyButton.setTitle("$", for: .normal)
        baseCurrencyButton.titleLabel?.font = UIFont.systemFont(ofSize: 53.0)
        baseCurrencyButton.setTitleColor(.white, for: .normal)
        baseCurrencyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // base currency textField
        baseCurrencyTextField.font = UIFont.systemFont(ofSize: 70.0)
        baseCurrencyTextField.textAlignment = .right
        baseCurrencyTextField.adjustsFontSizeToFitWidth = true
        baseCurrencyTextField.minimumFontSize = 17.0
        baseCurrencyTextField.borderStyle = .roundedRect
        
        baseCurrencyTextField.autocapitalizationType = .none
        baseCurrencyTextField.autocorrectionType = .no
        baseCurrencyTextField.spellCheckingType = .no
        baseCurrencyTextField.keyboardType = .decimalPad
        
        baseCurrencyTextField.addTarget(self, action: #selector(baseCurrTextFieldEditingChanged), for: .editingChanged)
        
        // base stack view
        baseStackView.addArrangedSubview(baseCurrencyButton)
        baseStackView.addArrangedSubview(baseCurrencyTextField)
        baseStackView.axis = .horizontal
        baseStackView.spacing = 10.0
        
        // convert currency button
        convertCurrencyButton.setImage(UIImage(named: "exchange"), for: .normal)
        convertCurrencyButton.tintColor = .white
        convertCurrencyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        convertCurrencyButton.addTarget(self, action: #selector(convertCurrencyButtonTapped), for: .touchUpInside)
        
        // convert currency text field
        convertCurrencyTextField.font = UIFont.systemFont(ofSize: 70.0)
        convertCurrencyTextField.textAlignment = .right
        convertCurrencyTextField.adjustsFontSizeToFitWidth = true
        convertCurrencyTextField.minimumFontSize = 17.0
        convertCurrencyTextField.borderStyle = .roundedRect
        
        convertCurrencyTextField.autocapitalizationType = .none
        convertCurrencyTextField.autocorrectionType = .no
        convertCurrencyTextField.spellCheckingType = .no
        convertCurrencyTextField.keyboardType = .decimalPad
        
        // convert stack view
        convertStackView.addArrangedSubview(convertCurrencyButton)
        convertStackView.addArrangedSubview(convertCurrencyTextField)
        convertStackView.axis = .horizontal
        convertStackView.spacing = 10.0
        
        // overall stack view
        overallStackView.addArrangedSubview(baseStackView)
        overallStackView.addArrangedSubview(convertStackView)
        overallStackView.axis = .vertical
        overallStackView.distribution = .fillEqually
        overallStackView.spacing = 70.0
        
        // currencies picker view
        currenciesPickerView.isHidden = true
        currenciesPickerView.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        
        // tap gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundWasTapped))
        
        
        view.addSubview(overallStackView)
        view.addSubview(currenciesPickerView)
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func setupConstraints() {
        
        // stack view
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        
        overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14.0).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14.0).isActive = true
        
        // picker view
        currenciesPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currenciesPickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.currenciesPickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            self.currenciesPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    
    // Actions
    @objc func baseCurrTextFieldEditingChanged() {
        convert()
    }
    
    @objc func convertCurrencyButtonTapped() {
        currenciesPickerView.isHidden = false
        baseCurrencyTextField.resignFirstResponder()
    }
    
    @objc func backgroundWasTapped() {
        baseCurrencyTextField.resignFirstResponder()
        convertCurrencyTextField.resignFirstResponder()
        currenciesPickerView.isHidden = true
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let textFieldContainsDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextContainsDecimalSeparator = string.range(of: ".")
        let replacementTextContainsLetters = string.rangeOfCharacter(from: .letters)
        
        if (textFieldContainsDecimalSeparator != nil && replacementTextContainsDecimalSeparator != nil) || replacementTextContainsLetters != nil {
            
            return false
        }
        
        if (textField.text == "") && (string.first == "0") {
            return false
        }
        
        return true
    }
    
    // MARK: - Methods
    func convert() {
        if let currencyValues = currencyValues,
            let baseCurrencyString = baseCurrencyTextField.text,
            let baseCurrencyValue = Double(baseCurrencyString),
            let convertedText = convertCurrencyButton.currentTitle,
            let convertCurrencyRate = currencyValues.rates[convertedText] {
            
            let resultAsNSNumber = NSNumber(value: baseCurrencyValue * convertCurrencyRate)
            convertCurrencyTextField.text = "\(numberFormatter.string(from: resultAsNSNumber) ?? "")"
        } else {
            convertCurrencyTextField.text = ""
        }
    }
}

// MARK: - UIPickerViewDataSource & UPickerViewDelegate
extension ConvertViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currenciesDictionary?.values.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let currencyDictionary = currenciesDictionary {
            
            let sorted = currencyDictionary.sorted(by: { (dict1, dict2) -> Bool in
                return dict1.value < dict2.value
            })
            return "\(sorted[row].value)"
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let currencyDictionary = currenciesDictionary {
            let sorted = currencyDictionary.sorted(by: { (dict1, dict2) -> Bool in
                return dict1.value < dict2.value
            })
            
            convertCurrencyButton.setTitle(sorted[row].key, for: .normal)
            convert()
        }
    }
    
}

