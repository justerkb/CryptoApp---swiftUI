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
        HStack(spacing: 0) {
            Text("\(Int(coin.marketCapRank ?? 0))")
                .font(.caption)
                .frame(minWidth: 30)
//                .background(Color.blue)
            CoinImageView(coin: coin)
                .frame(maxWidth: 30, maxHeight: 30)
                
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
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
//        .background(Color.green)
        .font(.subheadline)
    }
    
    
}


struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}
