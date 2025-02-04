//
//  HomeStatisticsView.swift
//  CryptoApp
//
//  Created by Yerkebulan on 01.02.2025.
//

import SwiftUI

struct HomeStatisticsView: View {
    
    @StateObject var homeVM: HomeViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            ForEach(homeVM.statistics) { stt in
                StatisticView(statistic: stt)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: homeVM.showPortfolio ? .trailing : .leading
        )
    }
}

#Preview {
    @State var port = false
    let viewmodel = HomeViewModel()
    HomeStatisticsView(homeVM: viewmodel)
}
