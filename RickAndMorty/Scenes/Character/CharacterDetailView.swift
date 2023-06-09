//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import SwiftUI

struct CharacterDetailView: View {

    @State private var showSheet = true
    @State private var selectedDetent = PresentationDetent.custom(TinyDetent.self)

    var detentButton: Button<Text> {
        if selectedDetent == .custom(TinyDetent.self) {
            return Button {
                selectedDetent = .medium
            } label: {
                Text("Show more")
                    .font(.caption)
            }
        } else {
            return Button {
                selectedDetent = .custom(TinyDetent.self)
            } label: {
                Text("Show less")
                    .font(.caption)
            }
        }
    }
    let character: Character
    
    var body: some View {
        VStack {
            AsyncImage(url: character.image) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .ignoresSafeArea(.all)
            } placeholder: {
                ProgressView()
            }
            .ignoresSafeArea(.all)
            ScrollView(.vertical) {
                Text(character.name)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 8)
                HStack {
                    Text("Species:")
                    Text(character.species)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                HStack {
                    Text("Status:")
                    Text(character.status.rawValue.capitalized)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                HStack {
                    Text("Gender:")
                    Text(character.gender.rawValue.capitalized)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                HStack {
                    Text("Origin:")
                    Text(character.origin.name)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Appears in")
                        Text("\(character.episode.count) episodes")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    EpisodeScrollview(episodes: character.episode)
                    HStack(alignment: .top) {
                        Text("Location ")
                            .font(.subheadline)
                        Text("\(character.location.name)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                }
            }
//            Spacer()
        }
        .ignoresSafeArea(.all)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {

    static let character = Character(id: 99,
                                     name: "Nardole",
                                     status: .alive,
                                     species: "Almost human",
                                     type: "Unknown",
                                     gender: .unknown,
                                     origin: Origin(name: "Bognor Regis", url: "https://en.wikipedia.org/wiki/Bognor_Regis"), location: CharacterLocation(name: "Milton Keynes", url: "https://en.wikipedia.org/wiki/Milton_Keynes"),
                                     image: URL(string: "https://ichef.bbci.co.uk/images/ic/1008xn/p04zmzxv.jpg")!,
                                     episode: [],
                                     url: URL(string: "https://www.bbc.co.uk/programmes/m0016lkw")!,
                                     created: Date.now)

    static var previews: some View {
        CharacterDetailView(character: character)
    }
}


struct TinyDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        if context.dynamicTypeSize.isAccessibilitySize {
            return 180
        } else {
            return 90
        }
    }
}
