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

    
    var body: some View {
        NavigationView {
            List(characters) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    CharacterListCell(character: character)
                        .frame(height: 100)
                        .listRowSeparator(.hidden)
                }
            }
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea(.horizontal)
            .listStyle(PlainListStyle())

            .navigationTitle("Characters")
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
