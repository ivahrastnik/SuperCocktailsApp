//
//  SearchViewModel.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 09.09.2026..
//

import Foundation
import SwiftUI
import Combine

private enum Query {
    case empty
    case searchOnly(text: String)
    case categoryOnly(category: Category)
    case both(text: String, category: Category)
    
    init(text: String, category: Category?) {
        switch (text.isEmpty, category) {
        case (true, nil): self = .empty
        case (false, nil): self = .searchOnly(text: text)
        case (true, .some(let category)): self = .categoryOnly(category: category)
        case (false, .some(let category)): self = .both(text: text, category: category)
        }
    }
}

class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var categoryPicked: Category?
    @Published var state: HomeState = .idle
    @Published var categories: [Category] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let apiClient: CocktailServicing
    
    init(apiClient: CocktailServicing = CocktailService()) {
        self.apiClient = apiClient
        loadCategories()
        combineSearchAndCategory()
    }
    
    private func combineSearchAndCategory() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .combineLatest($categoryPicked)
            .compactMap { [weak self] text, category -> AnyPublisher<HomeState, Never>? in
                return self?.mapResults(text: text, category: category)
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.state = newState
            }
            .store(in: &cancellables)
    }
    
    private func mapResults(text: String, category: Category?) -> AnyPublisher<HomeState, Never> {
        return switch Query(text: text, category: category) {
        case .empty:
            Just(HomeState.idle).eraseToAnyPublisher()
            
        case .searchOnly(text: let text):
            apiClient.fetchDrinksBySearchText(searchText: text)
                .map { response -> HomeState in
                    let cocktails = response.drinks ?? []
                    return cocktails.isEmpty ? .empty(searchText: text) : .loaded(cocktails)
                    
                }
                .catch { error -> AnyPublisher<HomeState, Never> in
                    return Just(HomeState.error(message: Constants.errorMessage))
                        .eraseToAnyPublisher()
                }
                .prepend(HomeState.loading)
                .eraseToAnyPublisher()
            
        case .categoryOnly(category: let category):
            apiClient.fetchDrinksByCategorySelected(category: category)
                .map { response -> HomeState in
                    let cocktails = response.drinks ?? []
                    return cocktails.isEmpty ? .empty(searchText: text) : .loaded(cocktails)
                    
                }
                .catch { error -> AnyPublisher<HomeState, Never> in
                    return Just(HomeState.error(message: Constants.errorMessage))
                        .eraseToAnyPublisher()
                }
                .prepend(HomeState.loading)
                .eraseToAnyPublisher()
            
        case .both(text: let text, category: let category):
            apiClient.fetchDrinksBySearchText(searchText: text)
                .map { response -> HomeState in
                    let cocktails = (response.drinks ?? []).filter { $0.category == category.name }
                    return cocktails.isEmpty ? .empty(searchText: text) : .loaded(cocktails)
                    
                }
                .catch { error -> AnyPublisher<HomeState, Never> in
                    return Just(HomeState.error(message: Constants.errorMessage))
                        .eraseToAnyPublisher()
                }
                .prepend(HomeState.loading)
                .eraseToAnyPublisher()
        }
    }
    
    private func loadCategories() {
           return apiClient.fetchCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                
                self?.categories = response.drinks ?? []
            })
            .store(in: &cancellables)
    }
}
