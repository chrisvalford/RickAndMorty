//
//  EpisodeFilteredList.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 12/6/23.
//

import SwiftUI

struct EpisodeFilteredList: View {

    @FetchRequest var episodes: FetchedResults<SeriesEpisode>

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(episodes) { episode in
                    EpisodeScrollviewCell(episode: episode)
                        .padding()
                }
            }
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
    }
}
