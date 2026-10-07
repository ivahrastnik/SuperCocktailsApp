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
                titleView
                scrollView
            }
            .padding(20)
        }
        .ignoresSafeArea()
    }
    
    var titleView: some View {
        return Text(cocktail.name)
            .foregroundStyle(Color.textAccent)
            .font(.title)
            .fontDesign(.monospaced)
        
    }
    
    var scrollView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                categoryTitleView(text: Constants.ingredientsLabel)
                IngredientsListView(ingredients: cocktail.ingredients)
                categoryTitleView(text: Constants.instructionsLabel)
                Text(cocktail.instructions)
                    .foregroundStyle(Color.textLowAccent)
                Text(Constants.dateFormatted(date: cocktail.dateModified))
                    .foregroundStyle(Color.textAccent)
                    .font(.caption2)
            }
        }
    }
    
    func categoryTitleView(text: String) -> some View {
        return Text(text.uppercased())
            .foregroundStyle(Color.textAccent)
            .font(.caption)
            .fontDesign(.monospaced)
        
    }
}
