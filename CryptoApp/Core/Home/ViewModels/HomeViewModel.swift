//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Yerkebulan on 31.12.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchedCoinText: String = ""
    @Published var showPortfolio: Bool = true

    var searchedCoins: [CoinModel] {
        return allCoins.filter { coin in
            coin.name.lowercased().contains(searchedCoinText.lowercased()) ||
            coin.symbol.lowercased().contains(searchedCoinText.lowercased())
        }
    }
    public let statistics: [StatisticModel] = [
       .init(title: "Market Cap", value: "$3.67", percentageChange: -2.54),
       .init(title: "24h Volume", value: "$146,23Bn"),
       .init(title: "BTC Dominance", value: "$55.39%"),
       .init(title: "Portfolio Value", value: "0.00", percentageChange: 12.2)
    ]

    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
//        dataService.$allCoins
//            .sink { [weak self] coins in
//                self?.allCoins = coins
//            }
//            .store(in: &cancellables)
        
        $searchedCoinText
            .combineLatest(dataService.$allCoins)
//            .debounce(for: 1, scheduler: DispatchQueue.main)
            .map{ text, StartingCoins -> [CoinModel] in
                if text.isEmpty { return StartingCoins }
                
                return StartingCoins.filter { coin in
                    coin.name.lowercased().contains(text.lowercased()) ||
                    coin.symbol.lowercased().contains(text.lowercased())
                }

            }
            .sink { returnedCoins in
                self.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
}
