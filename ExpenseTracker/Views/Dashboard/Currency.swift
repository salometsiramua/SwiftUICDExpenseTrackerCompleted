//
//  Currency.swift
//  ExpenseTracker
//
//  Created by Giorgi Chinchaladze on 15.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import Foundation

enum Currency: String, CaseIterable {
    case usd
    case eur
    
    var identifier: String {
        rawValue.uppercased()
    }
    
    var symbol: String {
        switch self {
        case .eur:
            return "€"
        case .usd:
            return "$"
        }
    }
    
    var alternate: Currency {
        self == .eur ? .usd : .eur
    }
    
    var index: Int {
        Currency.allCases.firstIndex(of: self) ?? 0
    }
}
