//
//  TransactionList.swift
//  ExpensesTracker
//
//  Created by MACM72 on 02/09/25.
//

import SwiftUI

struct TransactionList: View {
    
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        
        VStack {
            List {
                // MARK: Transaction Groups
                
                ForEach(Array(transactionListVM.groupTransactionsByMonth()),id:\.key) { month , transactions in
                    
                    Section(header: Text(month), content: {
                        ForEach(transactions){transaction in
                            TransactionRow(transaction: transaction)
                            
                        }
                    })
                    
                }
            }
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TransactionList()
        .environmentObject(ListTransactionListViewModelPreview.transactionListVM)
}
