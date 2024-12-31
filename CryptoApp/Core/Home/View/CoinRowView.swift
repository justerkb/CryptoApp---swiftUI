//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Yerkebulan on 15.12.2024.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
     
    var body: some View {
        HStack {
            Text("\(Int(coin.marketCapRank ?? 0))")
                .font(.caption)
                .frame(minWidth: 30)
                .background(Color.blue)
            Circle()
                .frame(width: 20, height: 20)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                Text(coin.priceChangePercentage24H?.asPercentage() ?? "%0,00")
                    .foregroundStyle(
                        (coin.athChangePercentage ?? 0 ) >= 0 ? Color.green : Color.red
                    )
            }
        }
        .background(Color.green)
        
        
    }
}


struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}
