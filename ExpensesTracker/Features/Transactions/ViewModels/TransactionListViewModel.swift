//
//  TRansactionListViewModel.swift
//  ExpensesTracker
//
//  Created by MACM72 on 02/09/25.
//


import Foundation
import Combine
import Collections


//typealias TransactionsGroup = [ String : [Transaction] ]

typealias TransactionsGroup = OrderedDictionary<String , [Transaction]>
typealias TransactionPefixSum = [ (String , Double) ]


final class TransactionListViewModel: ObservableObject {
    
    // ObservableObject turn any object into publisher
    // and will notify its subscriber of its changes
    // so thet can refersh their views
    
    // The property warpper @Publishes is responsible for sending
    // notification to subscribers whenever its value has changed
    
    @Published var transaction:[Transaction] = []
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            // Skip network fetch
            return
        }
        #endif
        getTransaction()
    }
    
    
    func getTransaction() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/savansamar/transaction/refs/heads/main/transaction-lits.json") else{
            print("Invalid URL")
            return
        }
        
        // MARK: Loader start
        isLoading = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error fetching transactions:", error.localizedDescription)
                    case .finished:
                        print("Finished fetching transactions")
                    }
                },
                receiveValue: { [weak self] result in
                    // MARK: Loader stop
                    self?.isLoading = true
                    self?.transaction = result
                    //dump(self?.transaction)
                    // When debugging API responses (dump(self?.transaction)
                    // helps you check the exact JSON decoded structure)
                }
            )
            .store(in: &cancellables)
        
    }
    
    func groupTransactionsByMonth() -> TransactionsGroup {
        guard !transaction.isEmpty else {
            return [:]
        }
        return TransactionsGroup(grouping:transaction){ $0.month }
    }
    
    func accumulateTransactions()-> TransactionPefixSum {
        print("accumulateTransactions")
        guard !transaction.isEmpty  else { return [] }
        
        
        let today = Date().formatted("MM/DD/YYYY").dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("dateInterval",dateInterval)
        
        var sum: Double = .zero
        var cumulateSum =  TransactionPefixSum()
        
        for date in stride(from: dateInterval.start , to: today , by: 60 * 60 * 24){
            let dailyExpenses = transaction.filter { $0.dateParsed == date && $0.isExenses }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulateSum.append((date.formatted(), sum))
            print(date.formatted() ,"daily total", dailyTotal, "sum: ",sum)
            
        }
        return cumulateSum
        
    }
    
}
