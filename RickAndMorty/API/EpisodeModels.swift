//
//  EpisodeModels.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 7/6/23.
//

import Foundation

public struct EpisodeResults: Codable {
  let info: Info
  let results: [Episode]
}

public struct Episode: Codable, Identifiable {
    public var id: String {
        return episode
    }
    let name: String
    let airDate: String
    let episode: String
    let characters: [URL]
    let url: URL
    let created: Date
}
