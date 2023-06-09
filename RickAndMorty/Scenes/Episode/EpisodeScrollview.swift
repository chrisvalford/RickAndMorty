//
//  EpisodeScrollview.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import SwiftUI

struct EpisodeScrollview: View {

    @State var model: EpisodeViewModel
    @State var episodes: [Episode] = []

    init(episodes: [URL]) {
        model = EpisodeViewModel()
        model.urls = episodes
    }
    
    var body: some View {
        VStack(alignment: .leading) {
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
        .padding(.horizontal)
        .onAppear {
            Task {
                await model.fetchAllEpisodes()
                self.episodes = model.episodes
            }
        }
    }
}

//struct EpisodeScrollview_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodeScrollview()
//    }
//}
