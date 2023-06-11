//
//  CharacterListCell.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import SwiftUI
import Kingfisher

struct CharacterListCell: View {

    let character: SeriesCharacter

    var body: some View {
        HStack {
            KFImage.url(character.image)
                .cancelOnDisappear(true)
                .resizable()
                .frame(width: 80, height: 80)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading) {
                Text(character.name ?? "")
                    .font(.headline)
                Text(character.species ?? "")
                    .font(.subheadline)
                Text(character.status?.capitalized ?? "")
                    .font(.subheadline)
//                Text("Appears in \(character.toEpisode!.count) episodes")
//                    .font(.subheadline)
            }
        }
    }
}

//struct CharacterListCell_Previews: PreviewProvider {
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
//    static var previews: some View {
//        CharacterListCell(character: character)
//    }
//}
