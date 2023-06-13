//
//  EpisodeModels.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 7/6/23.
//

import Foundation

public struct EpisodeResults: Decodable {
  let info: Info
  let results: [SeriesEpisode]
}
