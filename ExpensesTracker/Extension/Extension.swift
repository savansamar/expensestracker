import Foundation
import SwiftUI

extension Color {
    
    static let appBackground =  Color("Background")
    static let appIcon =  Color("Icon")
    static let appText =  Color("Text")
    static let appSystemBackground =  Color(uiColor: .systemBackground)
}


extension DateFormatter {
    // computed property
    // static helps to ensure there's only one instnace of it.
    static let allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}


extension String {
    
    func dateParsed() -> Date {
       guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date()}
        return parsedDate
    }
}

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    func roundedTo2Digits() -> Double {
        return (self*100).rounded() / 100
    }
}
