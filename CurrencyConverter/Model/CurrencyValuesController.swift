//
//  CurrencyValuesController.swift
//  CurrencyConverter
//
//  Created by Kudryatzhan Arziyev on 1/2/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

class CurrencyValuesController {
    
    static let shared = CurrencyValuesController()
    
    var currencyValues: CurrencyValues?
    
    let baseURL = URL(string: "https://openexchangerates.org/api/")
    let apiKey = "cbf0257f1574490fa48b1f71cc4741e3"
    
    // function to fetch info from API
    func getCurrencyValues(completion: @escaping (Bool) -> Void) {
        
        // URL
        guard let url = baseURL?.appendingPathComponent("latest.json") else { completion(false); return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        components?.queryItems = [
            URLQueryItem(name: "app_id", value: apiKey)
        ]
        
        guard let requestURL = components?.url else { completion(false); return }
        
       // Request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        // Data task
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Error: \(error)")
            }
            
            let decoder = JSONDecoder()
            
            guard let data = data else { completion(false); return }
            
            guard let currencyValuesDictionary = try? decoder.decode(CurrencyValues.self, from: data) else { completion(false); return }
            
            self.currencyValues = currencyValuesDictionary
            
            completion(true)
        }
        dataTask.resume()
    }
}
