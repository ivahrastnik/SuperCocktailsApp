//
//  SearchViewModel.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 09.09.2026..
//

import Foundation
import SwiftUI
import Combine

enum SearchState {
    case idle
    case loading
    case loaded([Cocktail])
    case empty(searchText: String)
    case error(message: String)
}

class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var state: SearchState = .idle
    
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
            state = .idle
            return
        }
        
        state = .loading
        
        Task {
            do {
                response = try await apiClient.fetchCocktails(searchText: text)
                let cocktails = response.drinks ?? []
                state = cocktails.isEmpty ? .empty(searchText: text) : .loaded(cocktails)
            } catch {
                state = .error(message: Constants.errorMessage)
            }
        }
    }
}
