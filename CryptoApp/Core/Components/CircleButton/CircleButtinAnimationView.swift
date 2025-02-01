//
//  CircleButtinAnimationView.swift
//  CryptoApp
//
//  Created by Yerkebulan on 14.12.2024.
//

import SwiftUI

struct CircleButtinAnimationView: View {
    
   @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1.0 : 0.1)
            .opacity(animate ? 0 : 1)
            .animation(.easeOut(duration: 1.0))
            .onAppear {
                animate.toggle()
            }
    }
}
