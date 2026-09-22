//
//  CategoryTitleView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 16.09.2026..
//
import SwiftUI

struct CategoryTitleView: View {
    let text: String
    var body: some View {
        Text(text.uppercased())
            .foregroundStyle(Color.textAccent)
            .font(.caption)
            .fontDesign(.monospaced)
    }
}
