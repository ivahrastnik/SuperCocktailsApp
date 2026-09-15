//
//  ListView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 08.09.2026..
//

import SwiftUI
import Combine
import Foundation

struct IconView: View { // move each view to its own file for better visibility
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
        .frame(width: 64, height: 64)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct ListCell: View {
    var cocktail: Cocktail
    var body: some View {
        HStack(spacing: 12) {
            IconView(imageUrl: cocktail.imageUrl ?? "")
            VStack(alignment: .leading, spacing: 4) {
                Text(cocktail.name)
                    .font(.headline)
                Text(cocktail.category)
                Text(cocktail.alcoholic.uppercased())
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.red)
                            .opacity(0.3)
                        
                    )
            }
            .foregroundStyle(Color.textAccent)
            .scaleEffect(0.8)
            Spacer()
            Image(systemName: "arrow.forward")
                .imageScale(.large)
                .foregroundStyle(Color.textAccent)   
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.appBackground)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct ListView: View { // does each of this View need to be a new struct? is there a better way to write it
    var cocktails: [Cocktail]?
    var body: some View {
        List(cocktails ?? []) { cocktail in // what is the difference between List and VStack?
            NavigationLink(value: cocktail) {
                ListCell(cocktail: cocktail)
            }
            .listRowBackground(Color.clear)
        }
        .padding(.horizontal, -24)
        .scrollContentBackground(.hidden)
    }
}

struct TitleView: View {
    var body: some View {
        Text("Cocktails")
            .foregroundStyle(Color.textAccent)
            .font(.title)
            .fontDesign(.monospaced)
    }
}

struct CocktailsListView: View {
    @StateObject private var viewModel = SearchViewModel() // what is the difference between StateObject and ObservedObject?
    @StateObject private var navigator = Navigator()
    var body: some View {
        NavigationStack(path: $navigator.path) {
            ZStack {
                Rectangle()
                    .fill(Color.appBackground)
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 12) { // do we need to always define spacing in VStack or HStack?
                    TitleView()
                    SearchView(viewModel: viewModel)
                    ListView(cocktails: viewModel.cocktails)
                    Spacer()
                }
                .padding(12)
                .foregroundStyle(Color.appBackground)
                .navigationDestination(for: Cocktail.self) { cocktail in
                    DetailView(cocktail: cocktail)
                }
            }
        }
    }
}

#Preview {
    CocktailsListView()
}
