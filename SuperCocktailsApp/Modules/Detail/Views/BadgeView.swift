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
                    .opacity(0.7)
                
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(badgeColor, lineWidth: 0.8)
            )
    }
}
