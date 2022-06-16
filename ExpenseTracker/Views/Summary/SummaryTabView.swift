//
//  SummaryTabView.swift
//  ExpenseTracker
//
//  Created by Salome Tsiramua on 15.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct SummaryTabView: View {
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SummaryTabView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryTabView()
    }
}
