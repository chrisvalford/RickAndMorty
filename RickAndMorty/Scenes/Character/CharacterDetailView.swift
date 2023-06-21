//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import SwiftUI
import Kingfisher

struct CharacterDetailView: View {

    @State private var rating = 0
    let character: SeriesCharacter
    
    var body: some View {
        VStack {
            KFImage.url(character.image)
                .cancelOnDisappear(true)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, alignment: .top)
                .ignoresSafeArea(.all)

            ScrollView(.vertical) {
                Text(character.name ?? "")
                    .font(.largeTitle)
                    .allowsTightening(true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 8)
                RatingView(rating: $rating)
                SubheadlineView(title: "Species", content: character.species ?? "")
                SubheadlineView(title: "Status", content: character.status!.capitalized)
                SubheadlineView(title: "Gender", content: character.gender!.capitalized)
                SubheadlineView(title: "Origin", content: character.toOrigin?.name ?? "")
                VStack(alignment: .leading) {
                    HStack {
                        Text("Appears in")
                        Text("\(character.episode!.count) episode\(character.episode!.count > 1 ? "s" : "")")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    EpisodeScrollview(urls: character.episode!)
                }
                SubheadlineView(title: "Location", content: character.toLocation?.name ?? "")
            }

        }
        .ignoresSafeArea(.all)
        .onAppear {
            let ratingModel = RatingModel()
            rating = ratingModel.getRating(forCharacterID: Int(character.id))
        }
        .onDisappear {
            let ratingModel = RatingModel()
            ratingModel.set(rating: rating, forCharacterID: Int(character.id))
        }
    }
}
