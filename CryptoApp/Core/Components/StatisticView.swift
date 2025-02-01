//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Yerkebulan on 01.02.2025.
//

import SwiftUI

struct StatisticView: View {
    
    let statistic: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(statistic.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(statistic.value)
                .foregroundStyle(.accent)
                .font(.headline)
                .fontWeight(.bold)
            if let percentageChange = statistic.percentageChange {
                HStack {
                    Image(systemName: percentageChange < 0 ?
                          "arrowtriangle.down.fill" : "arrowtriangle.up.fill")
                    .foregroundStyle((percentageChange < 0) ? .red : .green)
                    .font(.caption2)
                        
                    Text("\(percentageChange.asPercentage())")
                        .font(.caption)
                        .foregroundStyle((percentageChange < 0) ? .red : .green)
                }
            }
                
        }
        
    }
}

#Preview {
    StatisticView(statistic: .init(title: "Market Cap", value: "$3.23Tr", percentageChange: 11.3))
}
