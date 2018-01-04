//
//  ViewsForEdmundinho.swift
//  CurrencyConverter
//
//  Created by Kudryatzhan Arziyev on 1/4/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

// MARK: - Properties of views programmatically
var baseCurrencyButton = UIButton(type: .system)
var convertCurrencyButton = UIButton(type: .system)
var baseCurrencyTextField = UITextField()
var convertCurrencyTextField = UITextField()
var currenciesPickerView = UIPickerView()

// Stack views
let baseStackView = UIStackView(arrangedSubviews: [baseCurrencyButton, baseCurrencyTextField])
let convertStackView = UIStackView(arrangedSubviews: [convertCurrencyButton, convertCurrencyTextField])


