//
//  ListView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 08.09.2026..
//

import SwiftUI
import Combine
import Foundation

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var navigator = Navigator()
    var body: some View {
        NavigationStack(path: $navigator.path) {
            ZStack {
                Rectangle()
                    .fill(Color.appBackground)
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 12) {
                    VStack(alignment: .leading, spacing: 12) {
                        TitleView(text: "Cocktails")
                        SearchView(viewModel: viewModel)
                    }
                    
                    switch viewModel.state {
                    case .idle:
                        InitialView()
                    case .loading:
                        LoadingView()
                    case .loaded(let cocktails):
                        ListView(cocktails: cocktails)
                    case .empty(let searchText):
                        EmptyHomeView(searchText: searchText)
                    case .error(let message):
                        ErrorView(message: message)
                    }

                    Spacer()
                }
                .padding(12)
                .foregroundStyle(Color.appBackground)
                .navigationDestination(for: Cocktail.self) { cocktail in
                    DetailView(cocktail: cocktail)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
