//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Yerkebulan on 30.01.2025.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchedCoinText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(!searchedCoinText.isEmpty ? .accent : .secondaryText)
            TextField(text: $searchedCoinText) {
                Text("Search by name or symbol...")
                    
            }
            .autocorrectionDisabled(true)
            if !searchedCoinText.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .onTapGesture {
                        searchedCoinText = ""
                    }
                
            }
        }
        .font(.headline)
        .padding()
        .background(Color.theme.background)
        .cornerRadius (25)
        .shadow(color: Color.theme.accent.opacity(0.25), radius:10, x: 0, y: 0)
    }
}

#Preview {
    @State var text = ""
    SearchBarView(searchedCoinText: $text)
}
