//
//  ServiceManager.swift
//  ExpenseTracker
//
//  Created by Salome Tsiramua on 15.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import Foundation
import Alamofire

class ServiceManager {
    
    func fetchRate() {
       
        let endpoint = "https://elementsofdesign.api.stdlib.com/aavia-currency-converter@dev/"
        let parameters: [String: Any] = [
            "amount" : 102,
            "to_currency" : "EUR",
            "from_currency" : "USD"
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseDecodable(of: CurrencyResponse.self) { response in
            print(response)
        }
    }
}

struct CurrencyResponse: Decodable {
    let amount: Double
    let rate: Double
}

struct CurrencyRequest: Codable {
    let amount: Double
    let toCurrency: String
    let fromCurrency: String
    
    enum CodingKeys: String, CodingKey {
        case amount
        case toCurrency = "to_currency"
        case fromCurrency = "from_currency"
    }
    
    init(amount: Double = 0, toCurrency: Currency, fromCurrency: Currency) {
        self.amount = amount
        self.toCurrency = toCurrency.identifier
        self.fromCurrency = fromCurrency.identifier
    }
}
