//
//  Utils.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

struct Utils {
    
    static let dateFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()
    
    static func numberFormatter(for currency: Currency) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.currencyCode = currency.identifier
        formatter.numberStyle = .currency
        return formatter
    }
    
}
