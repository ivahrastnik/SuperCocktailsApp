//
//  LoadingView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 17.09.2026..
//
import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .tint(Color.textAccent)
                .scaleEffect(1.5)
            Text("Loading cocktails...")
                .foregroundStyle(Color.textAccent)
        }
    }
}
