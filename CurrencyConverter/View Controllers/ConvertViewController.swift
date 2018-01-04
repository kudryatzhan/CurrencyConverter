//
//  ConvertViewController.swift
//  CurrencyConverter
//
//  Created by Kudryatzhan Arziyev on 1/2/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController, UITextFieldDelegate {
    
    
    
    
    // IBOutlets
    @IBOutlet weak var baseCurrencyTextField: UITextField!
    @IBOutlet weak var convertedCurrencyTextField: UITextField!
    
    @IBOutlet weak var baseSignButton: UIButton!
    @IBOutlet weak var convertedSignButton: UIButton!
    
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    // MARK: - Properties
    var currencyValues: CurrencyValues?
    var currenciesDictionary: [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    // IBActions
    @IBAction func baseCurrTextFieldEditingChanged(_ sender: UITextField) {
        convert()
    }
    
    @IBAction func convertCurrencyButtonTapped(_ sender: UIButton) {
        currencyPickerView.isHidden = false
        baseCurrencyTextField.resignFirstResponder()
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
    
    @IBAction func backgroundWasTapped(_ sender: UITapGestureRecognizer) {
        baseCurrencyTextField.resignFirstResponder()
        convertedCurrencyTextField.resignFirstResponder()
        currencyPickerView.isHidden = true
    }
    
    // MARK: - Methods
    func convert() {
        if let currencyValues = currencyValues,
            let baseCurrencyString = baseCurrencyTextField.text,
            let baseCurrencyValue = Double(baseCurrencyString),
            let convertedText = convertedSignButton.currentTitle,
            let convertCurrencyRate = currencyValues.rates[convertedText] {
            
            let resultAsNSNumber = NSNumber(value: baseCurrencyValue * convertCurrencyRate)
            convertedCurrencyTextField.text = "\(numberFormatter.string(from: resultAsNSNumber) ?? "")"
        } else {
            convertedCurrencyTextField.text = ""
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
            
            convertedSignButton.setTitle(sorted[row].key, for: .normal)
            convert()
        }
    }
    
}

