//
//  ErrorView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 17.09.2026..
//
import SwiftUI

struct ErrorView: View {
    let message: String
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .foregroundStyle(.teal)
            Text(Constants.errorLabel)
                .font(.headline)
            Text(message)
        }
        .foregroundStyle(Color.textAccent)
    }
}
