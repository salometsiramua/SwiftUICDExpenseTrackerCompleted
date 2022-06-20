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
    
    @State var selectedMonths: Set<Month> = Set()
    @State private var sortType = SortType.date
    @State private var sortOrder = SortOrder.descending
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                FilterMonthsView(selectedMonths: $selectedMonths)
                Divider()
                LogListView(predicate: ExpenseLog.predicate(with: selectedMonths), sortDescriptor: ExpenseLogSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
            }
            .navigationBarTitle("Monthly Summary", displayMode: .inline)
        }
    }
}

struct SummaryTabView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryTabView()
    }
}
