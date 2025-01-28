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
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        dataService.$allCoins
            .sink { [weak self] coins in
                self?.allCoins = coins
                print(self?.allCoins)
            }
            .store(in: &cancellables)
    }
    
}
