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

    var body: some Scene {
        WindowGroup {
            CharacterListView()
            //ContentView()
            //    .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
