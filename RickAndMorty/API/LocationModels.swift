//
//  LocationModels.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 7/6/23.
//

import Foundation

public struct LocationResults: Codable {
    let info: Info
    let results: [Location]
}

public struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [URL]
    let url: URL
    let created: Date
}
