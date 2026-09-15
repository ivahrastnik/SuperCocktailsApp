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
} // move to models

protocol CocktailServicing { // it would make sense to create a separate folder called Networking that will contain this
    func fetchCocktails(searchText: String) async throws -> CocktailSearchResponse // how would you wrap this so that it returns a Combine publisher? 
}

class CocktailService: CocktailServicing {
    func fetchCocktails(searchText: String) async throws -> CocktailSearchResponse {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(searchText)") else {
            throw NetworkError.invalidURL
        } // create a file that would contain all constants, base url should be separated from path

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
