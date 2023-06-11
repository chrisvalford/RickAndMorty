//
//  ContentViewModel.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import Foundation

@MainActor
class CharacterViewModel: ObservableObject {

    @Published var characters: [SeriesCharacter] = []
    let api = API()

    func fetchAllCharacters() async {
        do {
            try await api.all(resultType: ResultType.character, url: "https://rickandmortyapi.com/api/character")
            repeat {
                try await api.all(resultType: ResultType.character, url: api.charactersInfo?.next?.absoluteString)
            } while api.charactersInfo?.next != nil
        } catch {
            print(error)
        }
    }
}
