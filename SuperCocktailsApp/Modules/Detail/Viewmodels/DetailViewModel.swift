//
//  DetailViewModel.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 18.09.2026..
//
import SwiftUI
import Combine

class DetailViewModel: ObservableObject {
    @Published var state: DetailState = .loading
    @Published var isRetrying: Bool = false
    let drink: Cocktail
    private let apiClient: CocktailServicing
    private var cancellables = Set<AnyCancellable>()
    
    init(apiClient: CocktailServicing = CocktailService(), drink: Cocktail) {
        self.apiClient = apiClient
        self.drink = drink
        loadDrinkDetails()
    }
    
    func reloadDetails() {
        isRetrying = true
        loadDrinkDetails()
    }
    
    private func loadDrinkDetails() {
        apiClient.fetchDrinkDetails(id: drink.id)
            .map { response -> DetailState in
                guard let drinkDetails = response.drinks?.first else {
                    return .error(message: Constants.errorDetailsMessage)
                }
                return .loaded(drinkDetails)
            }
            .catch { error -> AnyPublisher<DetailState, Never> in
                return Just(DetailState.error(message: Constants.errorDetailsMessage))
                    .eraseToAnyPublisher()
            }
            .prepend(.loading)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.isRetrying = false
                self?.state = newState
            }
            .store(in: &cancellables)
    }
}
