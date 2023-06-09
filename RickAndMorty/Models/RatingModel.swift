//
//  RatingModel.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 9/6/23.
//

import Foundation

// TODO: Using the old user defaults, migrate to CoreData
struct RatingModel {

    let userDefaults = UserDefaults.standard

    func set(rating: Int, forCharacterID: Int) {
        let key = String(format: "CharacterID%d", forCharacterID)
        if let _ = userDefaults.value(forKey: key) {
            // Update or, remove if rating is zero
            if rating == 0 {
                userDefaults.removeObject(forKey: key)
            } else {
                userDefaults.set(rating, forKey: key)
            }
        } else {
            userDefaults.set(rating, forKey: key)
        }
    }

    func getRating(forCharacterID: Int) -> Int {
        let key = String(format: "CharacterID%d", forCharacterID)
        return userDefaults.integer(forKey: key)
    }
}
