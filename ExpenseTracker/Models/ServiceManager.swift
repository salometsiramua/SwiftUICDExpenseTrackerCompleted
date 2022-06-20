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
    let endPoint = "https://elementsofdesign.api.stdlib.com/aavia-currency-converter@dev/"
    
    func fetchRate(for amount: Double = 0, from: Currency, to: Currency, completion: @escaping (Result<CurrencyResponse, AFError>)->()) {
       
        let parameters: [String: Any] = [
            CurrencyRequest.CodingKeys.amount.rawValue : amount,
            CurrencyRequest.CodingKeys.toCurrency.rawValue : to.identifier,
            CurrencyRequest.CodingKeys.fromCurrency.rawValue : from.identifier
        ]
        
        AF.request(endPoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseDecodable(of: CurrencyResponse.self) { response in
            completion(response.result)
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
