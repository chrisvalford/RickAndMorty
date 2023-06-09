//
//  EpisodeViewModel.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import Foundation

class EpisodeViewModel: ObservableObject {

    var urls: [URL] = []
    private(set) var episodes: [Episode] = []
    private let api = API()
    private var episodeIDs: [String] = []

    func fetchAllEpisodes() async {
        var path = "https://rickandmortyapi.com/api/episode/"
        for url in urls {
            episodeIDs.append(url.lastPathComponent)
        }
        if episodeIDs.isEmpty {
            do {
                try await api.all(resultType: ResultType.episode)
                episodes = api.episodes
            } catch {
                print(error)
            }
        } else {
            for id in episodeIDs {
                path.append(id)
                if id != episodeIDs.last {
                    path.append(",")
                }
            }
            do {
                try await api.all(resultType: ResultType.episode, url: path)
                episodes.append(contentsOf: api.episodes)
            } catch {
                print(error)
            }
        }
    }
}
