//
//  CharacterWidgetView.swift
//  RickAndMortyCharacterWidgetExtension
//
//  Created by Christopher Alford on 13/6/23.
//

import SwiftUI

struct CharacterWidgetView: View {

    @State private var rating = 0
    let character: WidgetCharacter
    let image: Image

    var body: some View {
        ZStack(alignment: .bottom) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
//                RatingView(rating: $rating)
                HStack {
                    Text("Species:")
                        .font(.caption)
                    Text(character.species)
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                HStack {
                    Text("Status:")
                        .font(.caption)
                    Text(character.status)
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
//                HStack {
//                    Text("Gender:")
//                        .font(.caption)
//                    Text(character.gender)
//                        .font(.caption)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal)
//                HStack {
//                    Text("Origin:")
//                        .font(.caption)
//                    Text(character.origin)
//                        .font(.caption)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal)
//                    HStack {
//                        Text("Appears in")
//                        Text("\((character.episode?.count)!) episodes")
//                            .font(.subheadline)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal)
                HStack(alignment: .top) {
                    Text("Location:")
                        .font(.caption)
                    Text("\(character.location)")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            }
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .ignoresSafeArea(.all)
//        .onAppear {
//            let ratingModel = RatingModel()
//            rating = ratingModel.getRating(forCharacterID: Int(character.id))
//        }
//        .onDisappear {
//            let ratingModel = RatingModel()
//            ratingModel.set(rating: rating, forCharacterID: Int(character.id))
//        }
    }
}
