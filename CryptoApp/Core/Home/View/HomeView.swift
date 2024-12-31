//
//  ContentView.swift
//  CryptoApp
//
//  Created by Yerkebulan on 12.12.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                
            VStack {
                headerView
                Spacer()
            }
            .padding(.horizontal, 20)

        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
    .toolbar(.hidden)
}

extension HomeView {
    
    private var headerView: some View {
        HStack {
            CircleButton(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CircleButtinAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio": "Live prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.accent)
                .animation(.none)
            
            Spacer()
            CircleButton(iconName: "chevron.right")
                .rotationEffect(.degrees(showPortfolio ? 180: 0))
                .onTapGesture {
                    withAnimation(.spring, {
                        showPortfolio.toggle()
                    })
                }
        }
    }
    
}
