//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Yerkebulan on 28.01.2025.
//

import SwiftUI




struct CoinImageView: View {
    
    @StateObject var viewModel: CoinImageViewModel
    
    init(coin: CoinModel) {
        _viewModel = .init(wrappedValue: .init(coin: coin))
    }
    
    
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
            }
            
        }
    }
}

#Preview {
    CoinImageView(coin: MocData.shared.coin) 
}
