//
//  Navigator.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 09.09.2026..
//
import Foundation
import Combine

@MainActor
class Navigator: ObservableObject {
    @Published var path: [Cocktail] = []
}
