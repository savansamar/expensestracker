
//
//  ContentView.swift
//  ExpensesTracker
//
//  Created by Dara To on 2022-03-04.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM : TransactionListViewModel
    var demoData:[Double] =  [8,2,4,6,12,9,2]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    // MARK: Chart
                    
                    let data = transactionListVM.accumulateTransactions()
                    let totalExpenses = data.last?.1 ?? 0
                    
                    CardView {
                        VStack {
//                            ChartLabel(totalExpenses.formatted(.currency(code: "USD")) ,type: .title)
                            ChartLabel("$4555", type: .title)
                            LineChart()
                        }
                        .background(Color.appSystemBackground)
                    }
                    .data(data)
                    .chartStyle(ChartStyle(backgroundColor: Color.appSystemBackground, foregroundColor: ColorGradient(Color.appIcon.opacity(0.4) , Color.appIcon)))
                    .frame(height:300)
                    
                    // MARK: Transaction List
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background) // assumes you have an extension for Color.background
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification Icon
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary) // assumes Color.icon extension
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

#Preview {
    ContentView()
}
