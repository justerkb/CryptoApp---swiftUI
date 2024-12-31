//
//  Double+Ext.swift
//  CryptoApp
//
//  Created by Yerkebulan on 15.12.2024.
//

import Foundation

extension Double {
    
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 6
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    public func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0,00"
    }
    
    public func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    public func asPercentage() -> String {
        return String(format: "%.2f%%", self)
    }
    
}
