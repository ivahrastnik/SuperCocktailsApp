//
//  SearchViewModel.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 09.09.2026..
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject { // think in this way: each screen or contextual part of the app will be in its own folder - this can be Home, and then Home would have its own View Model, View and Model. Home and Details would then be inside a Modules folder
    @Published var searchText: String = ""
    @Published var cocktails: [Cocktail] = []
    
    private var cancellables = Set<AnyCancellable>()
    private var response = CocktailSearchResponse(drinks: [])
    private let apiClient = CocktailService()
    
    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // what is scheduler: DispatchQueue.main? also what is the difference between debounce and throttle
            .removeDuplicates()
            .sink { [weak self] text in // what is [weak self] and what would happen if you remove it and keep self.performSearch(text)
                self?.performSearch(text)
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(_ text: String) {
        guard !text.isEmpty else {
            print("text empty")
            cocktails = []
            return
        }
        print("searching: \(text)")
        Task {
            response = try await apiClient.fetchCocktails(searchText: text) // make this to return a Combine publisher with the response
            cocktails = response.drinks ?? []
            print(cocktails)
        }
    }
}
