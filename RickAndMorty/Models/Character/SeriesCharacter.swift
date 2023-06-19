//
//  SeriesCharacter.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 11/6/23.
//

import Foundation
import CoreData

class SeriesCharacter: NSManagedObject, Decodable {
    
    enum CodingKeys: CodingKey {
        case id, name, status, species, type, gender, origin, location, image, episode, url, created
     }

    required convenience init(from decoder: Decoder) throws {
        guard let context = CodingUserInfoKey.context,
            let moc = decoder.userInfo[context] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

            self.init(context: moc)
            let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(String.self, forKey: .status)
        self.species = try container.decode(String.self, forKey: .species)
        self.type = try container.decode(String.self, forKey: .type)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.toOrigin = try container.decode(CharacterOrigin.self, forKey: .origin)
        self.toLocation = try container.decode(CharacterLocation.self, forKey: .location)
        self.image = try container.decode(URL.self, forKey: .image)
        self.episode = try container.decode([URL].self, forKey: .episode)
        self.url = try container.decode(URL.self, forKey: .url)
        self.created = try container.decode(Date.self, forKey: .created)
    }
}
