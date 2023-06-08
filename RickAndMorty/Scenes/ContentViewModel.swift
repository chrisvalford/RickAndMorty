//
//  ContentViewModel.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {

    @Published var characters: [Character] = []
    @Published var episodes: [Episode] = []
    @Published var locations: [Location] = []
    let api = API()

    func fetchAllCharacters() async {
        do {
            try await api.all(resultType: ResultType.character)
            characters = api.characters
            print("---------------------------")
            print("Characters")
            print("---------------------------")
            print("\(characters)")
        } catch {
            print(error)
        }
    }

    func fetchAllEpisodes() async {
        do {
            try await api.all(resultType: ResultType.episode)
            episodes = api.episodes
            print("---------------------------")
            print("Episodes")
            print("---------------------------")
            print("\(episodes)")
        } catch {
            print(error)
        }
    }

    func fetchAllLocations() async {
        do {
            try await api.all(resultType: ResultType.location)
            locations = api.locations
            print("---------------------------")
            print("Locations")
            print("---------------------------")
            print("\(locations)")
        } catch {
            print(error)
        }
    }

}
