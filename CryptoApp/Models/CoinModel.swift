//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Yerkebulan on 15.12.2024.
//

struct CoinModel: Codable, Identifiable, Equatable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    var currentHoldings: Double?
    
    func updateCurrentHoldings(value: Double) -> CoinModel {
        var coin = self
        coin.currentHoldings = value
        return coin
    }
    
    func currentHoldingsValue() -> Double? {
        guard let currentHoldings = currentHoldings else { return nil }
        return currentPrice * currentHoldings
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0) 
    }
}


struct SparklineIn7D: Codable, Equatable {
    let price: [Double]?
}
