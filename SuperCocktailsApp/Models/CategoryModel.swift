//
//  CategoryModel.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 30.09.2026..
//

import Foundation

struct Category: Decodable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }
}
