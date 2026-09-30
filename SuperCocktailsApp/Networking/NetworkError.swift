//
//  NetworkError.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 09.09.2026..
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidStatusCode(Int)
    case invalidResponse
    case decodingFailed
}
