//
//  CocktailModel.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 09.09.2026..
//

import Foundation

struct DynamicKey: CodingKey {
    var stringValue: String
    init(stringValue: String) { self.stringValue = stringValue }
    var intValue: Int? { nil }
    init?(intValue: Int) { nil }
}

enum CodingKeys: String, CodingKey {
    case id = "idDrink"
    case name = "strDrink"
    case category = "strCategory"
    case glass = "strGlass"
    case alcoholic = "strAlcoholic"
    case instructions = "strInstructions"
    case imageUrl = "strDrinkThumb"
    case dateModified
}

struct Cocktail: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let category: String
    let glass: String
    let alcoholic: String
    let instructions: String
    let imageUrl: String?
    let dateModified: String?
    var ingredients: [IngredientModel]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.glass = try container.decode(String.self, forKey: .glass)
        self.alcoholic = try container.decode(String.self, forKey: .alcoholic)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        self.dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)
        self.ingredients = []
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicKey.self)
        for i in 1...15 {
            let nameKey = DynamicKey.init(stringValue: "strIngredient\(i)")
            guard let name = try dynamicContainer.decodeIfPresent(String.self, forKey: nameKey) else { continue }
            
            let measureKey = DynamicKey.init(stringValue: "strMeasure\(i)")
            let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey)
            
            let ingredient = IngredientModel(name: name, measure: measure)
            self.ingredients.append(ingredient)
        }
    }
}
