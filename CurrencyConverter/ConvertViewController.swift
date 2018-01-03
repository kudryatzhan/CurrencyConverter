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
    
    // MARK: - Properties
    var currencyValues: CurrencyValues?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    // IBActions
    @IBAction func baseCurrTextFieldEditingChanged(_ sender: UITextField) {
        if let currencyValues = currencyValues,
            let baseCurrencyString = sender.text,
            let baseCurrencyValue = Double(baseCurrencyString),
            let convertCurrencyRate = currencyValues.rates["EUR"] {
            
            let resultAsNSNumber = NSNumber(value: baseCurrencyValue * convertCurrencyRate)
            convertedCurrencyTextField.text = "\(numberFormatter.string(from: resultAsNSNumber) ?? "")"
        } else {
            convertedCurrencyTextField.text = ""
        }
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
    }
    
    
}

