//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Yerkebulan on 28.01.2025.
//

import Combine
import Foundation
import SwiftUI

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    var imageSubscription: AnyCancellable?
    
    init(url: String) {
        loadImage(url: url)
    }
    
    private func loadImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        NetworkManager.shared.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.shared.handleCompletion, receiveValue: { [weak self] image in
                self?.image = image
                self?.imageSubscription?.cancel()
            })


    }
}
