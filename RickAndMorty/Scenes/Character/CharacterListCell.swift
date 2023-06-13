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
            }
        }
    }
}
