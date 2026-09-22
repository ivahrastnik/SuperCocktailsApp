//
//  DetailView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 08.09.2026..
//
import SwiftUI

struct DetailView: View {
    let viewModel: DetailViewModel
    private let cornerRadius: CGFloat = 20
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Color.appBackground
                
                IconView(imageUrl: viewModel.cocktail.imageUrl ?? "")
                    .frame(height: geo.size.height / 3 + cornerRadius)
                    .clipped()
                
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: geo.size.height / 3)
                    CocktailCardView(cocktail: viewModel.cocktail)
                        .frame(maxHeight: .infinity)
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: cornerRadius,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: cornerRadius
                            )
                        )
                }
            }
            .ignoresSafeArea()
        }
    }
}
