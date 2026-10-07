//
//  HomeState 2.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 05.10.2026..
//


enum DetailState {
    case loading
    case loaded(ApiCocktail)
    case error(message: String)
}
