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
    let dateKey = "LastUpdated"

    init() {
        if let lastUpdated = UserDefaults.standard.object(forKey: dateKey) as? Date {
            let now = Date.now.timeIntervalSinceReferenceDate
            let last = lastUpdated.timeIntervalSinceReferenceDate
            if (now - last) > (60*60*24) {
                fetchAllCharacters()
            }
        } else {
            fetchAllCharacters()
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

    func fetchAllCharacters() {
        let api = API()
        api.clearData()
        Task {
            await api.fetchAllCharacters()
        }
        UserDefaults.standard.set(Date(), forKey: dateKey)
    }
}
