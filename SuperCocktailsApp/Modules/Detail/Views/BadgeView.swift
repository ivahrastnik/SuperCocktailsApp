//
//  BadgeView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 10.09.2026..
//
 import SwiftUI

struct BadgeView: View {
    let text: String
    let badgeColor: Color
    var body: some View {
        Text(text.uppercased())
            .font(.caption)
            .padding(6)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(badgeColor)
                    .opacity(0.6)
                
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.textLowAccent, lineWidth: 0.5)
            )
    }
}
