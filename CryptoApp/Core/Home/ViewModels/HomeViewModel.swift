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
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .rankUp
    
    var isSortedByPriceUp: Bool {
        return sortOption == .priceUp
    }
    
    enum SortOption {
        case rankUp, rankDown, priceUp, priceDown
    }
    

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
            .combineLatest(dataService.$allCoins, $sortOption)
            .map(sortAndFilterCoins)
            .sink { [weak self ] returnedCoins in
                
                guard let self = self else { return }
                self.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        dataService.$allCoins
            .combineLatest(portfolioService.$allEntities)
            .sink { [weak self] coins, coinEntities in
                let updatedCoins = self?.mapAllCoinsToPortfolioCoins(allCoins: coins, portfolioEntities: coinEntities)
                self?.portfolioCoins = updatedCoins!
            }
            .store(in: &cancellables)

    }
    
    
    
    public func togglePriceSortOption() {
        if isSorted(by: .priceUp) {
            sortOption = .priceDown
        } else {
            sortOption = .priceUp
        }
    }
    
    public func toggleRankSortOption() {
        if isSorted(by: .rankUp) {
            sortOption = .rankDown
        } else {
            sortOption = .rankUp
        }
    }
    
    public func updatePorfolio(coin: CoinModel, amount: Double) {
        portfolioService.updatePorfolio(coin: coin, amount: amount)
    }
    
    private func sortAndFilterCoins(text: String, coins: [CoinModel], sortOption: SortOption) -> [CoinModel] {
        var filtredCoins = filterCoins(text: text, coins: coins)
        sortCoins(sortOption: sortOption, coins: &filtredCoins)
        
        return filtredCoins
    }
    
    
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        if text.isEmpty {
            return coins
        } else {
            return coins.filter { coin in
                coin.name.lowercased().contains(text.lowercased()) ||
                coin.symbol.lowercased().contains(text.lowercased())
            }
        }
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
    
    public func reloadAllCoins() {
        isLoading = true
        dataService.getCoins()
        
    }
    
    private func sortCoins(sortOption: SortOption, coins: inout [CoinModel]) {
        switch sortOption  {
        case .rankUp:
             coins.sort { $0.rank < $1.rank }
        case .rankDown:
             coins.sort { $0.rank > $1.rank }
        case .priceUp:
             coins.sort { $0.currentPrice > $1.currentPrice }
        case .priceDown:
             coins.sort { $0.currentPrice < $1.currentPrice }
        }
    }
    
    func isSorted(by option: SortOption) -> Bool {
        return sortOption == option
    }
}
