//
//  CocktailCardView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 16.09.2026..
//
import SwiftUI

struct CocktailCardView: View {
    let cocktail: Cocktail
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(Color.appBackground)
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    BadgeView(text: cocktail.category, badgeColor: .cellBackground)
                    BadgeView(text: cocktail.glass, badgeColor: .cellBackground)
                    BadgeView(text: cocktail.alcoholic, badgeColor: .red)
                }
                .foregroundStyle(Color.textAccent)
                TitleView(text: cocktail.name)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        CategoryTitleView(text: "Ingredients")
                        IngredientsListView(ingredients: cocktail.ingredients)
                        CategoryTitleView(text: "Instructions")
                        Text(cocktail.instructions)
                            .foregroundStyle(Color.textLowAccent)
                        Text("Updated: \(cocktail.dateModified ?? "Unknown")")
                            .foregroundStyle(Color.textAccent)
                            .font(.caption2)
                    }
                }
            }
            .padding(20)
        }
        .ignoresSafeArea()
    }
}
