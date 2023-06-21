//
//  Previewing.swift
//  SwiftUI-CoreData-WithEase
//
//  Created by Andy Nadal on 5/14/21.
//

import CoreData
import SwiftUI

struct Previewing<Content: View, Model>: View {
    var content: Content
    var persistence: PersistenceController

    /// Initializer that provides the instance of `model`
    init(_ keyPath: KeyPath<PreviewingData, (NSManagedObjectContext) -> Model>, @ViewBuilder content: (Model) -> Content) {

        self.persistence = PersistenceController(inMemory: true)
        let data = PreviewingData()
        let closure = data[keyPath: keyPath]
        let models = closure(persistence.container.viewContext)

        self.content = content(models)
    }

    /// Initializer that provides a context with an instance of `model`
    init(contextWith keyPath: KeyPath<PreviewingData, (NSManagedObjectContext) -> Model>, @ViewBuilder content: () -> Content) {

        self.persistence = PersistenceController(inMemory: true)
        let data = PreviewingData()
        let closure = data[keyPath: keyPath]

        // Ignore closure return, we just care about creating the data
        _ = closure(persistence.container.viewContext)

        self.content = content()
    }

    var body: some View {
        content
            .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}

struct PreviewingData {
    var seriesCharacters: (NSManagedObjectContext) -> [SeriesCharacter] { { context in
        var samples: [SeriesCharacter] = []
        for _ in 0..<15 {
            let sample = SeriesCharacter(context: context)
            sample.name = "Blob the builder"
            sample.species = "Alien"
            sample.status = "Alive"
            sample.image = URL(string: "https://rickandmortyapi.com/api/character/avatar/11.jpeg")!
            sample.created = Date().addingTimeInterval(-10000)
            samples.append(sample)
        }
        return samples
    } }

    var seriesCharacter: (NSManagedObjectContext) -> SeriesCharacter { { context in
        let sample = SeriesCharacter(context: context)
        sample.name = "Blob the builder"
        sample.species = "Alien"
        sample.status = "Alive"
        sample.image = URL(string: "https://rickandmortyapi.com/api/character/avatar/11.jpeg")!
        sample.created = Date().addingTimeInterval(-10000)
        return sample
    } }
}

