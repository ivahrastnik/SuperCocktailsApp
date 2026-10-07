//
//  CocktailCardView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 16.09.2026..
//
import SwiftUI

struct CocktailCardView: View {
    let title: String
    @ObservedObject var viewModel: DetailViewModel
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(Color.appBackground)
            switch viewModel.state {
            case .loading:
                loadingCard
            case .loaded(let apiCocktail):
                loadedCard(cocktail: apiCocktail)
            case .error(let message):
                ErrorDetailsView(title: title, message: message, viewModel: viewModel)
            }
        }
        .ignoresSafeArea()
    }
    
    func loadedCard(cocktail: ApiCocktail) -> some View {
        return VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                BadgeView(text: cocktail.category, badgeColor: .cellBackground)
                BadgeView(text: cocktail.glass, badgeColor: .cellBackground)
                BadgeView(text: cocktail.alcoholic, badgeColor: .red)
            }
            .foregroundStyle(Color.textAccent)
            titleView(name: cocktail.name)
            scrollView(ingredients: cocktail.ingredients, instructions: cocktail.instructions, date: cocktail.dateModified)
        }
        .padding(20)
    }
    
    var loadingCard: some View {
        VStack(alignment: .center, spacing: 12) {
            titleView(name: title)
            Spacer()
            ProgressView()
                .tint(Color.textAccent)
                .scaleEffect(1.5)
            Text(Constants.loadingDetailsMessage)
                .foregroundStyle(Color.textAccent)
            Spacer()
        }
        .padding(20)
    }
    
    func titleView(name: String) -> some View {
        return Text(name)
            .foregroundStyle(Color.textAccent)
            .font(.title)
            .fontDesign(.monospaced)
        
    }
    
    func scrollView(ingredients: [IngredientModel], instructions: String, date: String?) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                categoryTitleView(text: Constants.ingredientsLabel)
                IngredientsListView(ingredients: ingredients)
                categoryTitleView(text: Constants.instructionsLabel)
                Text(instructions)
                    .foregroundStyle(Color.textLowAccent)
                Text(Constants.dateFormatted(date: date))
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
