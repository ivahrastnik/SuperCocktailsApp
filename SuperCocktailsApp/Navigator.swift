//
//  Navigator.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 09.09.2026..
//
import Foundation
import Combine

@MainActor // what does MainActor do?
class Navigator: ObservableObject {
    @Published var path: [Cocktail] = []
}
