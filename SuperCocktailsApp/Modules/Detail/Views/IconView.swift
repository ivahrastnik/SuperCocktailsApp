//
//  IconView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 10.09.2026..
//
import SwiftUI

struct IconView: View {
    var imageUrl: String
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .empty:
                ProgressView()
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
    }
}
