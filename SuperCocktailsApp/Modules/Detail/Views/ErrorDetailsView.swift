//
//  ErrorCardView.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 07.10.2026..
//
import SwiftUI

struct ErrorDetailsView: View {
    let title: String
    let message: String
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text(title)
                .foregroundStyle(Color.textAccent)
                .font(.title)
                .fontDesign(.monospaced)
            Image(systemName: Constants.errorImageSource)
                .imageScale(.large)
                .foregroundStyle(.teal)
            Text(Constants.errorLabel)
                .font(.headline)
            Text(message)
            
            Button {
                viewModel.reloadDetails()
            } label: {
                if viewModel.isRetrying {
                    ProgressView()
                        .foregroundStyle(Color.textAccent)
                } else {
                    BadgeView(text: Constants.errorReloadButtonLabel, badgeColor: .textAccent)
                }
            }
            .disabled(viewModel.isRetrying)
            
        }
        .foregroundStyle(Color.textAccent)
        .padding(20)
    }
}
