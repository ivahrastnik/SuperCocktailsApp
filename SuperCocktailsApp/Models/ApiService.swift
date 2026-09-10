//
//  ApiService.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 09.09.2026..
//
import Foundation
import SwiftUI

struct CocktailSearchResponse: Decodable {
    let drinks: [Cocktail]?
}

protocol CocktailServicing {
    func fetchCocktails(searchText: String) async throws -> CocktailSearchResponse
}

class CocktailService: CocktailServicing {
    func fetchCocktails(searchText: String) async throws -> CocktailSearchResponse {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(searchText)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(CocktailSearchResponse.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
