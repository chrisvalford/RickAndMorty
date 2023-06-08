//
//  BaseModels.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 7/6/23.
//

import Foundation

struct Base: Codable {
    let name: String
    let path: URL
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: URL?
    let prev: URL?
}
