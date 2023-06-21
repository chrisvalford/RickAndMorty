//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import SwiftUI

struct CharacterListView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SeriesCharacter.name, ascending: true)],
        animation: .default)
    private var characters: FetchedResults<SeriesCharacter>

    @State private var searchText = ""
    @State private var sortAscending = true
    @State private var showWithRatingsOnly = false
    @State private var characterIDs: [Int32] = []

    private func updateCharacterIds(clear: Bool) {
        if clear == false {
            let model = RatingModel()
            let ids =  model.charactersWithRating()
            characterIDs = ids
        } else {
            characterIDs.removeAll()
        }
    }
    
    var body: some View {
        NavigationStack {
            CharacterFilteredList(filter: searchText, characterIDs: characterIDs, sortAscending: sortAscending)
            .navigationTitle("Characters")
            .searchable(text: $searchText, prompt: "Filter characters")
            .toolbar {
                Button {
                    showWithRatingsOnly.toggle()
                    if showWithRatingsOnly == true {
                        updateCharacterIds(clear: false)
                    } else {
                        updateCharacterIds(clear: true)
                    }
                } label: { Image(systemName: showWithRatingsOnly ? "star.fill" : "star") }

                Button {
                    sortAscending.toggle()
                } label: { Image(systemName: "arrow.up.arrow.down") }
            }
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        Previewing(contextWith: \.seriesCharacters) {
            CharacterListView()
        }
    }
}
