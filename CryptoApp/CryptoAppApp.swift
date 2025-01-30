//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Yerkebulan on 12.12.2024.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @StateObject var homeVM = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(homeVM)
        }
    }
}




