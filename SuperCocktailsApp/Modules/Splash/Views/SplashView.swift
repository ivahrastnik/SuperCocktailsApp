//
//  SplashView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 08.09.2026..
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.appBackground)
            VStack(spacing: 12) {
                Image(systemName: "wineglass")
                    .imageScale(.large)
                    .foregroundStyle(.teal)
                Text("SUPER")
                    .font(.headline)
                    .foregroundStyle(.white)
                Text("COCKTAILS")
                    .font(.largeTitle)
                    .foregroundStyle(.teal.secondary)
                Text("Tonight's pour, sorted.")
                    .font(.caption2)
                    .foregroundStyle(.white)
            }
            .fontDesign(.monospaced)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
