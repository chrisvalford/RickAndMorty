//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 7/6/23.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        let api = API()
        api.clearData()
        let model = CharacterViewModel()
        Task {
            await model.fetchAllCharacters()
        }
    }

    var body: some Scene {
        WindowGroup {
            CharacterListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.backward.circle")
                    UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward.circle")

                }
        }
    }
}
