//
//  Constants.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 17.09.2026..
//

import Foundation

enum Constants {
    static let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/"
    static let searchPath = "search.php?s="
    static let errorMessage = "Could not load cocktails. Check your connection and try again."
    static let loadingMessage = "Loading cocktails..."
    static let idleMessage = "Try searching for your favorite drink!"
    static let homeTitle = "Cocktails"
    static let errorLabel = "Something went wrong!"
    static let emptyTitle = "No results"
    static let ingredientsLabel = "Ingredients"
    static let instructionsLabel = "Instructions"
    static func emptyLabel(text: String) -> String {
        return "No cocktails found for \(text). Try another name."
    }
    static func dateFormatted(date: String?) -> String {
        guard let date else {
            return "Updated: Unknown"
        }
        
        let dateOnly = date.prefix(10)
        return "Updated: \(dateOnly)"
    }
}
