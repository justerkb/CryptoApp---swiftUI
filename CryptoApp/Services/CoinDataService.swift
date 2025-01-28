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
    
    private func getCoins() {
        
        let endpoint = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: endpoint) else { return }
        
        coinSubscribption = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap{ (output) -> Data in
                guard let responce = output.response as? HTTPURLResponse, responce.statusCode >= 200 && responce.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return decoder
            }())
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] returnedCoins in
                print(returnedCoins)
                self?.allCoins = returnedCoins
            })
    }
}
