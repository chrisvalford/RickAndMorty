//
//  EpisodeModels.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 7/6/23.
//

import Foundation

struct EpisodeResults: Codable {
  let info: Info
  let results: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [URL]
    let url: URL
    let created: Date //"2017-11-10T12:56:33.798Z"
  }
