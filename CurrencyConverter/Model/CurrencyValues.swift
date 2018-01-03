//
//  CurrencyValues.swift
//  CurrencyConverter
//
//  Created by Kudryatzhan Arziyev on 1/2/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

struct CurrencyValues: Codable {
    
    enum CodingKeys: String, CodingKey {
        case base = "base"
        case license = "license"
        case timestamp = "timestamp"
        case rates = "rates"
    }
    
    let base: String
    let license: String
    let timestamp: Double
    let rates: [String: Double]
}

