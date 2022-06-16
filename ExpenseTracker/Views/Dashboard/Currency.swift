//
//  Currency.swift
//  ExpenseTracker
//
//  Created by Giorgi Chinchaladze on 15.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import Foundation

enum Currency: String {
    case usd
    case eur
    
    var identifier: String {
        rawValue.uppercased()
    }
}
