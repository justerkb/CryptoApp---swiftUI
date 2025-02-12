//
//  ContentView.swift
//  CryptoApp
//
//  Created by Yerkebulan on 12.12.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var homeVM: HomeViewModel
    @State var showPortfolioView: Bool = false
    private let portfolioDataService = PortfolioCoinDataService()
    
    
    var body: some View {
        ZStack {
            Color.theme.background
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(homeVM)
            })
            
            VStack(spacing: 18) {
                headerView
                
                HomeStatisticsView(homeVM: homeVM)
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
                
                SearchBarView(searchedCoinText: $homeVM.searchedCoinText)
                    .padding(.horizontal)

                
                HStack {
                    Text("Coin")
                    Spacer()
                    Text("Holdings")
                    Text("Price")
                }
                .padding(.horizontal)
                
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                
                if !homeVM.showPortfolio {
                    allCoinsList
                } else {
                    portfolioList
                }
                
                
                Spacer()
                    
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .environmentObject(HomeViewModel())
    }
    .toolbar(.hidden)
}

extension HomeView {
    
    private var headerView: some View {
        HStack {
            CircleButton(iconName: homeVM.showPortfolio ? "plus" : "info")
                .background(
                    CircleButtinAnimationView(animate: $homeVM.showPortfolio)
                )
                .onTapGesture {
                    showPortfolioView.toggle()
                }
            Spacer()
            Text(homeVM.showPortfolio ? "Portfolio": "Live prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.accent)
                .animation(.none)
            
            Spacer()
            CircleButton(iconName: "chevron.right")
                .rotationEffect(.degrees(homeVM.showPortfolio ? 180: 0))
                .onTapGesture {
                    withAnimation(.spring, {
                        homeVM.showPortfolio.toggle()
                    })
                }
        }
        .padding(.horizontal, 32)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(homeVM.allCoins) { coin in
                CoinRowView(coin: coin)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .transition(.move(edge: .leading))
        .listStyle(PlainListStyle())
    }
    
    private var portfolioList: some View {
        List {
            ForEach(homeVM.portfolioCoins) { coin in
                CoinRowView(coin: coin)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
        }
        .transition(.move(edge: .trailing))
        .listStyle(PlainListStyle())
    }
    
}
