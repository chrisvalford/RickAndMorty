//
//  Image+Data.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 13/6/23.
//

import SwiftUI

extension Image {

    init(data: Data) {
        guard let image = UIImage(data: data) else {
            self = Image(systemName: "photo")
            return
        }
        self = .init(uiImage: image)
    }
}
