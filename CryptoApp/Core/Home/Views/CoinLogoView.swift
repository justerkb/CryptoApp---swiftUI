//
//  CoinColumnView.swift
//  CryptoApp
//
//  Created by Yerkebulan on 03.02.2025.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .foregroundStyle(.accent)
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            Text(coin.name)
                .foregroundStyle(.secondaryText)
                .font(.caption)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinLogoView(coin: MocData.shared.coin)
}
