//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardTabView(currency: .usd)
                .tabItem {
                    VStack {
                        Text(Strings.Main.dashboard.rawValue)
                        Image(systemName: Strings.Main.dashboardIconName.rawValue)
                    }
            }
            .tag(0)

            LogsTabView()
                .tabItem {
                    VStack {
                        Text(Strings.Main.logs.rawValue)
                        Image(systemName: Strings.Main.logsIconName.rawValue)
                    }
            }
            .tag(1)
            
            SummaryTabView()
                .tabItem {
                    VStack {
                        Text(Strings.Main.summary.rawValue)
                        Image(systemName: Strings.Main.summaryIconName.rawValue)
                    }
            }
            .tag(2)
        }.accentColor(Colors.selectedTab)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       
        let coreDataStack = CoreDataStack(containerName: "ExpenseTracker")

        ContentView()
                .environment(\.managedObjectContext, coreDataStack.viewContext)
    }
}
