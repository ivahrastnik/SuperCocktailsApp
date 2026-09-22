//
//  ListCellView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 16.09.2026..
//
import SwiftUI

struct ListCellView: View {
    let cocktail: Cocktail
    var body: some View {
        HStack(spacing: 12) {
            IconView(imageUrl: cocktail.imageUrl ?? "")
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading, spacing: 4) {
                Text(cocktail.name)
                    .font(.headline)
                Text(cocktail.category)
                BadgeView(text: cocktail.alcoholic, badgeColor: .red)
            }
            .foregroundStyle(Color.textAccent)
            .scaleEffect(0.8)
            Spacer()
            Image(systemName: "arrow.forward")
                .imageScale(.large)
                .foregroundStyle(Color.textAccent)   
        }
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.cellBackground)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
