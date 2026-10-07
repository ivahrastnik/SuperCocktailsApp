//
//  CocktailModel.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 01.10.2026..
//

import Foundation

struct Cocktail: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let imageUrl: String?
    let category: String?

    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case imageUrl = "strDrinkThumb"
        case category = "strCategory"
    }
}
