//
//  Double.swift
//  uberClone
//
//  Created by Rahul shah on 26/04/23.
//

import Foundation
extension Double {
    private var currencyFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    func toCurrency() -> String {
        return currencyFormatter.string(for: self) ?? ""
    }
}
