//
//  StatisticModel.swift
//  CryptoApp
//
//  Created by Yerkebulan on 01.02.2025.
//

import Foundation

class StatisticModel: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
