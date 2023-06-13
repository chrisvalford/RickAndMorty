//
//  CharacterLocation.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 11/6/23.
//

import Foundation
import CoreData

class CharacterLocation: NSManagedObject, Decodable {

    enum CodingKeys: CodingKey {
        case name, url
     }

    required convenience init(from decoder: Decoder) throws {
        guard let context = CodingUserInfoKey.context,
            let moc = decoder.userInfo[context] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

            self.init(context: moc)
            let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }
}
