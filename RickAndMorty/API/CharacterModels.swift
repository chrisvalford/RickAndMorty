//
//  CharacterModels.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 7/6/23.
//

import Foundation

public enum CharacterState: String, Codable {
    case unknown
    case alive
    case dead

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawString = try container.decode(String.self)
        if let state = CharacterState(rawValue: rawString.lowercased()) {
            self = state
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot initialize CharacterState from invalid String value \(rawString)")
        }
    }
}

public enum CharacterGender: String, Codable {
    case unknown
    case female
    case male
    case genderless

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawString = try container.decode(String.self)
        if let gender = CharacterGender(rawValue: rawString.lowercased()) {
            self = gender
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot initialize CharacterGender from invalid String value \(rawString)")
        }
    }
}

public struct CharacterResults: Decodable {
    let info: Info
    let results: [SeriesCharacter]
}
