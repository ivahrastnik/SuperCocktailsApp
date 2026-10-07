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
    func fetchCocktails(searchText: String) -> AnyPublisher<CocktailSearchResponse, NetworkError>
}

class CocktailService: CocktailServicing {
    func fetchCocktails(searchText: String) -> AnyPublisher<CocktailSearchResponse, NetworkError> {
        guard let url = URL(string: Constants.baseURL + Constants.searchPath + searchText) else {
            return Fail(outputType: CocktailSearchResponse.self, failure: NetworkError.invalidURL)
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
            .decode(type: CocktailSearchResponse.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.decodingFailed
                }
            }
            .eraseToAnyPublisher()
    }
}
