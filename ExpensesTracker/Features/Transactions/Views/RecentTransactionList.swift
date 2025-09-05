//
//  RecentTransactionList.swift
//  ExpensesTracker
//
//  Created by MACM72 on 02/09/25.
//

import SwiftUI

struct RecentTransactionList: View {
    
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent Transaction")
                    .bold()
                
                Spacer()
                
                // MARK: Header Link
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("See all")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            
            // MARK: Recent Transaction List
            
            ForEach(Array(transactionListVM.transaction.enumerated()),id: \.offset ) { index , transaction in
                TransactionRow(transaction: transaction)
                
                Divider()
                    .opacity( index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.appSystemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20 , style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x:0, y:5)
    }
}

struct TransactionListViewModelPreview {
    static let transactionListVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        // transactionListPreviewData come from preview content , it's dummy data
        vm.transaction = transactionListPreviewData
        return vm
    }()
}
#Preview {
    RecentTransactionList()
        .environmentObject(TransactionListViewModelPreview.transactionListVM)
}
