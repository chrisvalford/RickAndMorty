//
//  EpisodeTests.swift
//  RickAndMortyTests
//
//  Created by Christopher Alford on 9/6/23.
//

import XCTest

final class EpisodeTests: XCTestCase {

    func testAllEpisodeFetch() throws {
        let model = EpisodeViewModel()
        Task {
            await model.fetchAllEpisodes()
            assert(model.episodes.count > 0)
        }
    }

    func testSingleEpisodeFetch() throws {
        let episode: [URL] = [URL(string: "https://rickandmortyapi.com/api/episode/10")!]
        let model = EpisodeViewModel()
        model.urls = episode
        Task {
            await model.fetchAllEpisodes()
            assert(model.episodes.count == 1)
        }
    }

    func testMultipleEpisodeFetch() throws {
        let episodes: [URL] = [URL(string: "https://rickandmortyapi.com/api/episode/10")!,URL(string: "https://rickandmortyapi.com/api/episode/99")!,URL(string: "https://rickandmortyapi.com/api/episode/32")!]
        let model = EpisodeViewModel()
        model.urls = episodes
        Task {
            await model.fetchAllEpisodes()
            assert(model.episodes.count == 2)
        }
    }
}
