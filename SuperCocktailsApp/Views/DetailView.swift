//
//  DetailView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 08.09.2026..
//
import SwiftUI

struct DetailView: View {
    var cocktail: Cocktail
    var body: some View {
        VStack(spacing: 8) {
            Text(cocktail.name)
                .font(.largeTitle)
            Text("INSTRUCTIONS")
                .font(.headline)
            Text(cocktail.instructions)
                .font(.headline)
        }
    }
}
