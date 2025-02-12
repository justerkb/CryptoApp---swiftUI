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
    @Environment(\.presentationMode) var presentationMode
    @State var text: String = ""
    @State var amount: Double = 0.0
    @State var showChekMark: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                SearchBarView(searchedCoinText: $homeVM.coinToAddSearchText)
                    .padding(.top, 12)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing:10) {
                        ForEach(homeVM.portfolioCoins) { coin in
                            CoinLogoView(coin: coin)
                                .frame(width: 75)
//                                .background(Color.red)
                                .onTapGesture(perform: {
                                    withAnimation {
                                        self.selectedCoin = coin
                                    }
                                })
                                .padding(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.green, lineWidth: (selectedCoin?.id == coin.id) ? 1 : 0)
                                )
                            
                        }
                    }
                    .frame(height: 120)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                }
                
                if let coin = selectedCoin, !homeVM.searchedCoinText.isEmpty {
                    HStack {
                        Text("Current price of \(coin.symbol.uppercased())")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(coin.currentPrice.asCurrencyWith6Decimals())
                            .fontWeight(.semibold)
                    }
                    .padding()
                    Divider()
                    HStack {
                        Text("Amount holding")
                        Spacer()
                        TextField("Ex: 1.4", text: $text)
                            .onChange(of: text, {
                                self.amount = Double(text) ?? 0.0
                            })
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                        
                    }
                    .padding()
                    
                    Divider()
                    HStack {
                        Text("Current value:")
                        Spacer()
                        Text((amount * coin.currentPrice).asCurrencyWith6Decimals())
                            .fontWeight(.semibold)
                    }
                    .padding()
                }
                
                Spacer()
            }
            
            .navigationTitle("Edit Portfolio")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(alignment: .top) {
                            if showChekMark {
                                Image(systemName: "checkmark")
                            }
        
                            
                            Button("SAVE") {
                                saveButtonPressed()
                            }
                            .opacity(
                                (amount > 0 && !showChekMark) ? 1 : 0
                            )
                        }
                        .font(.headline)


                    }
                
                
            }
            
        }
    }
    
    private func saveButtonPressed() {
        
        withAnimation(.easeIn) {
            showChekMark = true
        }
        
        homeVM.updatePorfolio(coin: selectedCoin!, amount: amount)
        
        selectedCoin = nil
        amount = 0.0
        text = ""
        homeVM.searchedCoinText = ""
        //hide keyBoard
        ///.....
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            showChekMark = false
        })
        
        
    }
    
}

#Preview {
    let homeVM = HomeViewModel()
    @State var text = ""

    PortfolioView()
        .environmentObject(homeVM)
    
}
