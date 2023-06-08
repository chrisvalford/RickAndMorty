//
//  EpisodeViewModel.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import Foundation

class EpisodeViewModel: ObservableObject {

    @Published var episodes: [Episode] = []
    let api = API()

    func fetchAllEpisodes() async {
        do {
            try await api.all(resultType: ResultType.episode)
            episodes = api.episodes
        } catch {
            print(error)
        }
    }
}
