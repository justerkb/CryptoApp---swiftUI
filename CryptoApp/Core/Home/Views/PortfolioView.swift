//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Yerkebulan on 03.02.2025.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    @State var selectedCoin: CoinModel?
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                SearchBarView(searchedCoinText: $homeVM.searchedCoinText)
                    .padding(.top, 12)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(homeVM.allPortfolioCoins) { coin in
                            CoinColumnView(coin: coin, isSelected: selectedCoin == coin)
                                .onTapGesture(perform: {
                                    self.selectedCoin = coin
                                    print(selectedCoin?.name)
                                })
                                .frame(width: UIScreen.main.bounds.width / 4)
                        }

                    }
                }
                Spacer()

            }
            
            .navigationTitle("Edit Portfolio")
            .navigationBarTitleDisplayMode(.large)
            
        }
        
      

        
    }
    
}

#Preview {
    let homeVM = HomeViewModel()
    PortfolioView()
        .environmentObject(homeVM)
    
}
