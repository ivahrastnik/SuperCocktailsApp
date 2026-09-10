//
//  SuperCocktailsAppApp.swift
//  SuperCocktailsApp
//
//  Created by Iva Hrastnik on 08.09.2026..
//

import SwiftUI

@main
struct SuperCocktailsAppApp: App {
    @State private var isShowingSplash = true
    var body: some Scene {
        WindowGroup {
            Group {
                if isShowingSplash {
                    SplashView()
                        .transition(.opacity)
                    
                } else {
                    CocktailsListView()
                        .transition(.opacity)
                }
            }
            .task {
                try? await Task.sleep(for: .seconds(3))
                withAnimation(.linear(duration: 3)) {
                    isShowingSplash = false
                }
            }
        }
    }
}
