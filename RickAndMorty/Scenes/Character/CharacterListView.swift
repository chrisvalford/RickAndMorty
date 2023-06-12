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
    
    var body: some View {
        NavigationStack {
            CharacterFilteredList(filter: searchText, sortAscending: sortAscending)
                .navigationTitle("Characters")
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            sortAscending.toggle()
                        }) {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                )
        }
        .searchable(text: $searchText, prompt: "Filter characters")
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
