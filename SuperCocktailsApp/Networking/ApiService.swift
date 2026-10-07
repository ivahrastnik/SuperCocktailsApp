//
//  ApiService.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 09.09.2026..
//
import Foundation
import SwiftUI
import Combine

protocol CocktailServicing {
    func fetchDrinksBySearchText(searchText: String) -> AnyPublisher<CocktailResponse, NetworkError>
    func fetchCategories() -> AnyPublisher<CategoryListResponse, NetworkError>
    func fetchDrinksByCategorySelected(category: Category) -> AnyPublisher<CocktailResponse, NetworkError>
    func fetchDrinkDetails(id: String) -> AnyPublisher<DrinkDetailsResponse, NetworkError>
}

class CocktailService: CocktailServicing {
    
    private func fetchDataFromURL<T: Decodable>(urlString: String) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: urlString) else {
            return Fail(outputType: T.self, failure: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidStatusCode(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.decodingFailed
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchDrinksBySearchText(searchText: String) -> AnyPublisher<CocktailResponse, NetworkError> {
        return fetchDataFromURL(urlString: Constants.baseURL + Constants.searchPath + searchText)
    }
    
    func fetchCategories() -> AnyPublisher<CategoryListResponse, NetworkError> {
        return fetchDataFromURL(urlString: Constants.baseURL + Constants.allCategoriesPath)
    }
    
    func fetchDrinksByCategorySelected(category: Category) -> AnyPublisher<CocktailResponse, NetworkError> {
        return fetchDataFromURL(urlString: Constants.baseURL + Constants.categoryListPath(category: category.name))
    }
    
    func fetchDrinkDetails(id: String) -> AnyPublisher<DrinkDetailsResponse, NetworkError> {
        return fetchDataFromURL(urlString: Constants.baseURL + Constants.idPath + id)
    }
}
