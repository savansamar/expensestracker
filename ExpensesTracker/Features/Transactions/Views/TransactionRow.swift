//
//  TransactionRow.swift
//  ExpensesTracker
//
//  Created by MACM72 on 01/09/25.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    
    var transaction: Transaction
    
    private let formatted = Date().formatted(.dateTime.year().month().day())
    
    var body: some View {
        HStack(spacing:20) {
            // MARK: Transaction Category Icon
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.appIcon.opacity(0.3))
                .frame(width: 44 ,height: 44)
                .overlay{
                    FontIcon.text(.awesome5Solid(code: transaction.icon) , fontsize: 24 ,color: Color.appIcon)
                }
            
            VStack(alignment: .leading,spacing: 6) {
                
                // MARK: Transaction Merchant
                Text(transaction.merchnat)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                // MARK: Transaction Category
                Text(transaction.merchnat)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                // MARK: Transaction Date
                Text(transaction.dateParsed ,format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
            }
            Spacer()
            
            // MARK: Transaction Amount
            Text(transaction.signedAmount ,format:.currency(code: "USD") )
                .bold()
                .foregroundStyle(transaction.type == TransactionType.credit.rawValue ? Color.appText : .primary)
        }
        .padding([.top , .bottom],8)
    }
}

#Preview {
    TransactionRow(transaction: transactionPreviewData)
//    TransactionRow(transaction: transactionPreviewData).preferredColorScheme(.dark)
}
