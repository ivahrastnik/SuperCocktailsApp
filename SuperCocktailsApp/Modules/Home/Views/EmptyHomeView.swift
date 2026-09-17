//
//  EmptyHomeView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 17.09.2026..
//
import SwiftUI

struct EmptyHomeView: View {
    let searchText: String
    var body: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .imageScale(.large)
                .foregroundStyle(.teal)
            Text("No results")
                .font(.headline)
            Text("Try again")
        }
        .foregroundStyle(Color.textAccent)
    }
}
