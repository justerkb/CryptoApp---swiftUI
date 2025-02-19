//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Yerkebulan on 08.01.2025.
//

import Foundation
import SwiftUI
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    
    var cancalable = Set<AnyCancellable>()
    private var coinSubscribption : AnyCancellable?

    init () {
       getCoins()
    }
    
    public func getCoins() {
        
        let endpoint = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: endpoint) else { return }
        
        coinSubscribption = NetworkManager.shared.download(url: url) 
            .decode(type: [CoinModel].self, decoder: {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return decoder
            }())
            .sink(receiveCompletion: NetworkManager.shared.handleCompletion, receiveValue: { [weak self] returnedCoins in
                print(returnedCoins)
                self?.allCoins = returnedCoins
                self?.coinSubscribption?.cancel()
            })
    }
    
    
}
