//
//  HomeState.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 05.10.2026..
//

enum HomeState {
    case idle
    case loading
    case loaded([Cocktail])
    case empty(searchText: String)
    case error(message: String)
}
