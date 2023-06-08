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

    func isLastCharacter(_ id: Int) -> Bool {
        if characters.isEmpty {
            return true
        }
        if (characters.last! as Character).id == id {
            return true
        }
        return false
    }

    func fetchAllCharacters() async {
        do {
            try await api.all(resultType: ResultType.character)
            characters = api.characters.sorted {
                if $0.episode.count !=  $1.episode.count {
                    return $0.episode.count >  $1.episode.count
                } else {
                    return $0.name < $1.name
                }
            }

            print("---------------------------")
            print("Characters")
            print("---------------------------")
            print("\(String(describing: api.charactersInfo))")
        } catch {
            print(error)
        }
    }

    func fetchMoreCharacters() async {
        if api.charactersInfo?.next != nil {
            print("Fetching more")
            do {
                try await api.all(resultType: ResultType.character, url: api.charactersInfo?.next?.absoluteString)
               characters.append(contentsOf: api.characters)
//                characters.append(contentsOf: api.characters.sorted {
//                    if $0.episode.count !=  $1.episode.count {
//                        return $0.episode.count >  $1.episode.count
//                    } else {
//                        return $0.name < $1.name
//                    }
//                })
            } catch {
                print(error)
            }
        }
    }

    func fetchAllEpisodes() async {
        do {
            try await api.all(resultType: ResultType.episode)
            episodes = api.episodes
            print("---------------------------")
            print("Episodes")
            print("---------------------------")
            print("\(String(describing: api.episodesInfo))")
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
            print("\(String(describing: api.locationsInfo))")
        } catch {
            print(error)
        }
    }

}
