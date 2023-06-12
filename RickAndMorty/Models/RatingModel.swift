//
//  RatingModel.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 9/6/23.
//

import Foundation
import CoreData

struct RatingModel {

    let moc = PersistenceController.shared.container.newBackgroundContext()

    func getRating(forCharacterID: Int) -> Int {
        guard let rating = getCharacterRating(forCharacterID: forCharacterID) else { return 0 }
        return Int(rating.rating)
    }

    func set(rating: Int, forCharacterID: Int) {
        let foundRating = getCharacterRating(forCharacterID: forCharacterID)
        if foundRating != nil {
            if rating == 0 {
                moc.delete(foundRating!)
            } else {
                foundRating?.rating = Int16(rating)
            }
        } else {
            let newRating = CharacterRating(context: moc)
            newRating.id = Int32(forCharacterID)
            newRating.rating = Int16(rating)
        }

        do {
            try moc.save()
        } catch {
            print(error)
        }
    }

    private func getCharacterRating(forCharacterID: Int) -> CharacterRating? {
        let request = NSFetchRequest<CharacterRating>(entityName: "CharacterRating")
        request.predicate = NSPredicate(format: "id == %d", forCharacterID)
        do {
            let result = try moc.fetch(request).first
            return result
        } catch {
            print(error)
            return nil
        }
    }
}
