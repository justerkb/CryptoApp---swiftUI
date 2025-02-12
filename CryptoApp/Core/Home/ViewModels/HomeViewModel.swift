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
    @Published var allPortfolioCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchedCoinText: String = ""
    @Published var coinToAddSearchText: String = ""
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
    private let portfolioService = PortfolioCoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
                
        $searchedCoinText
            .combineLatest(dataService.$allCoins)
            .sink { [weak self] text, startingCoins in
                guard let self = self else { return }
                
                if text.isEmpty {
                    self.allCoins = startingCoins
                    self.allPortfolioCoins = []
                } else {
                    let filtredCoins = startingCoins.filter { coin in
                        coin.name.lowercased().contains(text.lowercased()) ||
                        coin.symbol.lowercased().contains(text.lowercased())
                    }
                    self.allPortfolioCoins = filtredCoins
                    self.allCoins = filtredCoins
                }
            }
            .store(in: &cancellables)
        
        dataService.$allCoins
            .combineLatest(portfolioService.$allEntities)
            .sink { [weak self] coins, coinEntities in
                let updatedCoins = self?.mapAllCoinsToPortfolioCoins(allCoins: coins, portfolioEntities: coinEntities)
                self?.portfolioCoins = updatedCoins!
            }
            .store(in: &cancellables)
        
        $searchedCoinText
            .combineLatest(dataService.$allCoins)
            .sink { [weak self] text, startingCoins in
                guard let self = self else { return }
                
                if !text.isEmpty {
                    let filtredCoins = startingCoins.filter { coin in
                        coin.name.lowercased().contains(text.lowercased()) ||
                        coin.symbol.lowercased().contains(text.lowercased())
                    }
                    self.allPortfolioCoins = filtredCoins
                    self.allCoins = filtredCoins
                }
            }
            .store(in: &cancellables)
    }
    
    
    
    public func updatePorfolio(coin: CoinModel, amount: Double) {
        portfolioService.updatePorfolio(coin: coin, amount: amount)
    }
    
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [CoinEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.id == coin.id }) else {
                    return nil
                }
                return coin.updateCurrentHoldings(value: entity.amount)
            }
    }
}
