//
//  IngredientsListView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 16.09.2026..
//
import SwiftUI

struct IngredientsListView: View {
    let ingredients: [IngredientModel]
    var body: some View {
        VStack(spacing: 0) {
            ForEach(ingredients, id: \.name) { ingredient in
                VStack{
                    HStack() {
                        Text(ingredient.name)
                            .foregroundStyle(Color.textAccent)
                        Spacer()
                        Text(ingredient.measure ?? "")
                            .foregroundStyle(Color.textLowAccent)
                    }
                    .padding(12)
                }
                if ingredient.name != ingredients.last?.name {
                    Divider()
                        .foregroundStyle(Color.textLowAccent)
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.textLowAccent, lineWidth: 0.5)
        )
    }
}
