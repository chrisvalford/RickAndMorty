//
//  EpisodeScrollviewCell.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import SwiftUI

struct EpisodeScrollviewCell: View {

    var episode: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(episode)
            Text("airDate")
            Text("episode")
        }
    }
}

struct EpisodeScrollviewCell_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeScrollviewCell()
    }
}
