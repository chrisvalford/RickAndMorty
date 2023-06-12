//
//  CharacterModels.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 7/6/23.
//

import Foundation

public struct CharacterResults: Decodable {
    let info: Info
    let results: [SeriesCharacter]
}
