//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import SwiftUI

struct CharacterListView: View {

    @ObservedObject var model = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List(model.characters) { character in
                CharacterListCell(character: character)
                    .frame(height: 100)
                    .listRowSeparator(.hidden)
                    .onAppear {
                        self.elementOnAppear(character)
                    }
            }
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea(.horizontal)
            .listStyle(PlainListStyle())

            .navigationTitle("Characters")
            .onAppear {
                Task {
                    await model.fetchAllCharacters()
                }
            }
        }
    }

    private func elementOnAppear(_ character: Character) {
        if model.isLastCharacter(character.id) {
            Task {
                await model.fetchMoreCharacters()
            }
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
