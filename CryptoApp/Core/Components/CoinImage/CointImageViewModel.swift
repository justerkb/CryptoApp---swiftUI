//
//  CointImageViewModel.swift
//  CryptoApp
//
//  Created by Yerkebulan on 29.01.2025.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let dataService: CoinImageService
    private let coin: CoinModel
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(url: coin.image)
        loadImage()
        self.isLoading = true
    }
    
    private func loadImage() {
        
        dataService.$image.sink { [unowned self] _ in
            self.isLoading = false
        } receiveValue: { [unowned self] returnedImage in
            self.image = returnedImage
        }
        .store(in: &cancellables)

    
    }
    
    
}
