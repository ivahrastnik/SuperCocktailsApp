//
//  TitleView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 10.09.2026..
//
import SwiftUI

struct TitleView: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundStyle(Color.textAccent)
            .font(.title)
            .fontDesign(.monospaced)
    }
}
