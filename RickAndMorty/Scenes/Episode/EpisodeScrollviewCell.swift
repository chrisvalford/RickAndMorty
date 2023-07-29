//
//  EpisodeScrollviewCell.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import SwiftUI

struct EpisodeScrollviewCell: View {

    var episode: SeriesEpisode

    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.name ?? "")
                .font(.headline)
            Text(episode.airDate ?? "")
                .font(.subheadline)
            Text(episode.episode ?? "")
                .font(.subheadline)
        }
    }
}
