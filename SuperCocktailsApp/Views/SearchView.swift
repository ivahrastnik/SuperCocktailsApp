//
//  SearchView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 09.09.2026..
//
import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.textAccent)
                .frame(height: 36)
            
            TextField("Search by name", text: $viewModel.searchText)
                .padding(12)
        }
    }
}
