//
//  PreviewData.swift
//  ExpensesTracker
//
//  Created by MACM72 on 01/09/25.
//


import Foundation

var transactionPreviewData = Transaction(
    id: 1,
    date: "2025-09-01",
    institution: "HDFC Bank",
    account: "Savings",
    merchnat: "Amazon",
    amount: 1200.50,
    type: "credit",
    categoryId: 1,
    category: "Shopping",
    isPending: false,
    isTransfer: false,
    isExenses: true,
    isEdited: false
)

var transactionListPreviewData = [Transaction](repeating:transactionPreviewData, count: 10)
