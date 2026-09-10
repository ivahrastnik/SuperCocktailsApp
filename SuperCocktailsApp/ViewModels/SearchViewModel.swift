//
//  SearchViewModel.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 09.09.2026..
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var cocktails: [Cocktail] = []
    
    private var cancellables = Set<AnyCancellable>()
    private var response = CocktailSearchResponse(drinks: [])
    private let apiClient = CocktailService()
    
    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
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
            response = try await apiClient.fetchCocktails(searchText: text)
            cocktails = response.drinks ?? []
            print(cocktails)
        }
    }
}
