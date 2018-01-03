//
//  HelperMethods.swift
//  CurrencyConverter
//
//  Created by Kudryatzhan Arziyev on 1/3/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 2
    
    return formatter
}()
