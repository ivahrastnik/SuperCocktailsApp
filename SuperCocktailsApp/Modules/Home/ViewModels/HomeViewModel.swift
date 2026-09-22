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
    private let apiClient = CocktailService()
    
    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { [apiClient] text -> AnyPublisher<SearchState, Never> in
                guard !text.isEmpty else {
                    return Just(SearchState.idle).eraseToAnyPublisher()
                }
                return apiClient.fetchCocktails(searchText: text)
                    .map { response -> SearchState in
                        let cocktails = response.drinks ?? []
                        return cocktails.isEmpty ? .empty(searchText: text) : .loaded(cocktails)
                        
                    }
                    .catch { error -> AnyPublisher<SearchState, Never> in
                        return Just(SearchState.error(message: Constants.errorMessage))
                            .eraseToAnyPublisher()
                    }
                    .prepend(SearchState.loading)
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.state = newState
            }
            .store(in: &cancellables)
    }
}
