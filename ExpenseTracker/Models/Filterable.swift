//
//  Filterable.swift
//  ExpenseTracker
//
//  Created by Salome Tsiramua on 6/20/22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import Foundation
import SwiftUI

protocol Filterable: Hashable, Identifiable {
    var color: Color { get }
    var value: String { get }
}

