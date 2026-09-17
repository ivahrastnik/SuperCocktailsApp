//
//  ListView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 16.09.2026..
//
import SwiftUI

struct ListView: View {
    let cocktails: [Cocktail]?
    var body: some View {
        List(cocktails ?? []) { cocktail in
            NavigationLink(value: cocktail) {
                ListCellView(cocktail: cocktail)
                    .padding(.vertical, -12)
            }
            .listRowBackground(Color.appBackground)
        }
        .padding(.vertical, -12)
        .padding(.leading, -40)
        .padding(.trailing, -60)
        .scrollContentBackground(.hidden)
    }
}
