//
//  EpisodeScrollview.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import SwiftUI

struct EpisodeScrollview: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SeriesEpisode.name, ascending: true)],
        animation: .default)
    private var episodes: FetchedResults<SeriesEpisode>

    var urls: [URL] = []
    @State var ids: [Int] = []
    let api = API()
    
    var body: some View {
        VStack(alignment: .leading) {
            EpisodeFilteredList(episodes: FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "url IN %@", urls)))
        }
        .padding(.horizontal)
        .onAppear {
            Task {
                await api.fetchEpisodes(urls: urls)
            }
        }
    }
}
