//
//  WidgetCharacter.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 13/6/23.
//

import SwiftUI

class WidgetCharacter: Identifiable {
    let id: Int
    let gender: String
    let image: URL
    var imageData: Data = Data()
    let location: String
    let name: String
    let origin: String
    let species: String
    let status: String

    init(id: Int, gender: String, image: URL, location: String,
     name: String, origin: String, species: String, status: String) {
        self.id = id
        self.gender = gender
        self.image = image
        self.location = location
        self.name = name
        self.origin = origin
        self.species = species
        self.status = status
        let task = URLSession.shared.dataTask(with: image) {
            (data, _, _) in
            if let data = data {
                self.imageData = data
            } else {
                self.imageData = (UIImage(systemName: "photo")?.pngData())!
            }
        }
        task.resume()
    }
}
