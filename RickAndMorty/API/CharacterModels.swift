//
//  CharacterModels.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 7/6/23.
//

import Foundation

struct CharacterResults: Codable {
    let info: Info
    let results: [Character]
}

struct Character: Codable, Identifiable  {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: CharacterLocation
    let image: URL
    let episode: [URL]
    let url: URL
    let created: Date // "2018-01-10T18:20:41.703Z"
}

struct Origin: Codable {
    let name: String
    let url: URL
}

struct CharacterLocation: Codable {
    let name: String
    let url: URL
}

