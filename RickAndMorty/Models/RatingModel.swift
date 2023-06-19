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

    func charactersWithRating() -> [Int32] {
        let request = NSFetchRequest<CharacterRating>(entityName: "CharacterRating")
        do {
            let results = try moc.fetch(request)
            if results.count < 1 {
                return []
            }
            var characterIDs: [Int32] = []
            for result in results {
                characterIDs.append(result.id)
            }
            return characterIDs
        } catch {
            print(error)
        }
        return []
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
