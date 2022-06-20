//
//  Strings.swift
//  ExpenseTracker
//
//  Created by Salome Tsiramua on 6/17/22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import Foundation

struct Strings {
    enum Main: String {
        case dashboard = "Dashboard"
        case dashboardIconName = "chart.pie"
        case logs = "Logs"
        case logsIconName = "tray"
        case summary = "Summary"
        case summaryIconName = "chart.bar"
    }
    
    enum Dashboard: String {
        case breakdown = "Breakdown"
        case totalExpenses = "Total expenses"
        case noExpenses = "No expenses data\nPlease add your expenses from the logs tab"
    }
    
    enum Logs: String {
        case search = "Search expenses"
        case expenseLogs = "Expense logs"
        case add = "Add"
    }
}
