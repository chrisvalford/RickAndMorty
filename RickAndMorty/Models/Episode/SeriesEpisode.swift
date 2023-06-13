//
//  SeriesEpisode.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 12/6/23.
//

import Foundation
import CoreData

class SeriesEpisode: NSManagedObject, Decodable {

    enum CodingKeys: CodingKey {
        case name, airDate, episode, characters, url, created
     }

    required convenience init(from decoder: Decoder) throws {
        guard let context = CodingUserInfoKey.context,
            let moc = decoder.userInfo[context] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

            self.init(context: moc)
            let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.airDate = try container.decode(String.self, forKey: .airDate)
        self.episode = try container.decode(String.self, forKey: .episode)
        self.characters = try container.decode([URL].self, forKey: .characters)
        self.url = try container.decode(URL.self, forKey: .url)
        self.created = try container.decode(Date.self, forKey: .created)
    }
}
