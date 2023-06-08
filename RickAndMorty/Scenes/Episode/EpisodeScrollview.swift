//
//  EpisodeScrollview.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import SwiftUI

struct EpisodeScrollview: View {

    var episodes: [String] = ["One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Last"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Episodes")
                .font(.callout)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(episodes, id: \.self) { episode in
                        EpisodeScrollviewCell(episode: episode)
                            .padding()
                    }
                }
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
    }
}

struct EpisodeScrollview_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeScrollview()
    }
}
