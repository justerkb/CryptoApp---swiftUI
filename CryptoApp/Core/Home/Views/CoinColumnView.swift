//
//  CoinColumnView.swift
//  CryptoApp
//
//  Created by Yerkebulan on 03.02.2025.
//

import SwiftUI

struct CoinColumnView: View {
    
    let coin: CoinModel
    var isSelected: Bool
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .foregroundStyle(.accent)
                .font(.headline)
            Text(coin.name)
                .foregroundStyle(.secondaryText)
                .font(.caption)
        }
        .padding(.horizontal)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.green, lineWidth: isSelected ? 2 : 0)
            
        )
        
        
    }
}

#Preview {
    CoinColumnView(coin: MocData.shared.coin, isSelected: true)
}
