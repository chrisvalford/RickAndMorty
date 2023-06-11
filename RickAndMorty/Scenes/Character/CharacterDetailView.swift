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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 8)
                RatingView(rating: $rating)
                HStack {
                    Text("Species:")
                    Text(character.species ?? "")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                HStack {
                    Text("Status:")
                    Text(character.status!.capitalized)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                HStack {
                    Text("Gender:")
                    Text(character.gender!.capitalized)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                HStack {
                    Text("Origin:")
                    Text((character.toOrigin?.name)!)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Appears in")
                        Text("\((character.episode?.count)!) episodes")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    EpisodeScrollview(episodes: character.episode!)
                    HStack(alignment: .top) {
                        Text("Location ")
                            .font(.subheadline)
                        Text("\((character.toLocation?.name)!)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                }
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

//struct CharacterDetailView_Previews: PreviewProvider {
//
//    static let character = Character(id: 99,
//                                     name: "Nardole",
//                                     status: .alive,
//                                     species: "Almost human",
//                                     type: "Unknown",
//                                     gender: .unknown,
//                                     origin: Origin(name: "Bognor Regis", url: "https://en.wikipedia.org/wiki/Bognor_Regis"), location: CharacterLocation(name: "Milton Keynes", url: "https://en.wikipedia.org/wiki/Milton_Keynes"),
//                                     image: URL(string: "https://ichef.bbci.co.uk/images/ic/1008xn/p04zmzxv.jpg")!,
//                                     episode: [],
//                                     url: URL(string: "https://www.bbc.co.uk/programmes/m0016lkw")!,
//                                     created: Date.now)
//
//    static var previews: some View {
//        CharacterDetailView(character: character)
//    }
//}
