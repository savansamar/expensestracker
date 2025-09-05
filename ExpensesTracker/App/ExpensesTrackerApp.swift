//
//  App.swift
//  ExpensesTracker
//
//  Created by MACM72 on 02/09/25.
//

import SwiftUI

@main
struct ExpensesTrackerApp: App {
    
    @StateObject  var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}

