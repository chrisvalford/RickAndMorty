//
//  API.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import Foundation
import CoreData

public enum ResultType: String, Codable {
    case character, episode, location
}

class API {

    var charactersInfo: Info?
    var episodesInfo: Info?
    var locationsInfo: Info?

    private var askedForMultipleEpisodes = false

    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
        case invalidJSON
        case coredataError
    }

    let moc = PersistenceController.shared.container.newBackgroundContext()

    /*
     * Deletes most of our coredata records
     */
    func clearData() {
        let psc = PersistenceController.shared.container.persistentStoreCoordinator
        let context = PersistenceController.shared.container.viewContext
        var fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SeriesCharacter")
        var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try psc.execute(deleteRequest, with: context)
        } catch {
            print(error)
        }

        fetchRequest = NSFetchRequest(entityName: "SeriesEpisode")
        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try psc.execute(deleteRequest, with: context)
        } catch {
            print(error)
        }
    }

    /*
     * Fetch all the decoded json records for the Result Type
     */
    func all<T: RawRepresentable>(resultType: T, url: String? = nil) async throws {
        do {
            let data = try await data(resultType: resultType, url: url)
            let decoder = JSONDecoder()
            guard let context = CodingUserInfoKey.context else {
                print("Error fetching CodingUserInfoKey.context!")
                throw APIError.coredataError
            }

            decoder.userInfo[context] = self.moc
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            switch resultType as? ResultType {
            case .character:
                let wrapped = try decoder.decode(CharacterResults.self, from: data)
                try self.moc.save()
                charactersInfo = wrapped.info

            case .episode:
                // Have we asked for more than one episode?
                if askedForMultipleEpisodes == true {
                    _ = try decoder.decode([SeriesEpisode].self, from: data)
                } else {
                    _ = try decoder.decode(SeriesEpisode.self, from: data)
                }
                try self.moc.save()

            case .location:
                let wrapped = try decoder.decode(LocationResults.self, from: data)
                locationsInfo = wrapped.info
                
            default:
                throw APIError.invalidJSON
            }
        } catch {
            print(error)
            throw APIError.invalidJSON
        }
    }

    // MARK: - Private
    /*
     * Fetch the data for the specified ResultType
     */
    private func data<T>(resultType: T, url: String? = nil) async throws -> Data {
        var dataUrl: URL
        if url != nil {
            // A next or previous page url has been given
            guard let pageUrl = URL(string: url ?? "") else {
                throw APIError.invalidURL
            }
            dataUrl = pageUrl
        } else {
            guard let url = URL(string: basePath+(resultType as! ResultType).rawValue) else {
                throw APIError.invalidURL
            }
            dataUrl = url
        }
        print("URL: \(dataUrl.absoluteString)")
        let urlSession = URLSession(configuration: sessionConfiguration)
        let (data, response) = try await urlSession.data(from: dataUrl)
        let success = 200..<299 ~= (response as? HTTPURLResponse)?.statusCode ?? 0
        if success == false {
            throw APIError.invalidResponse
        }
        return data
    }

    //TODO: Check against device 12/24 Hr clock
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }

    private var sessionConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return configuration
    }

    // MARK: - Characters
    func fetchAllCharacters() async {
        do {
            try await self.all(resultType: ResultType.character, url: "https://rickandmortyapi.com/api/character")
            repeat {
                try await self.all(resultType: ResultType.character, url: self.charactersInfo?.next?.absoluteString)
            } while self.charactersInfo?.next != nil
        } catch {
            print(error)
        }
    }

    func randomCharacter() -> SeriesCharacter {
        var results: [SeriesCharacter] = []
        let request = NSFetchRequest<SeriesCharacter>(entityName: "SeriesCharacter")
        //request.predicate = NSPredicate(format: "id == %i", Int32(10)) //Int.random(in: 1..<42))
        do {
            results = try moc.fetch(request)
            return results[0]
        } catch {
            print(error)
        }
        return results[0]
    }
    // MARK: - Episodes
    func fetchEpisode(url: URL) async {
        do {
            try await self.all(resultType: ResultType.episode, url: url.absoluteString)
        } catch {
            print(error)
        }
    }

    func fetchEpisodes(urls: [URL]) async {
        let request = NSFetchRequest<SeriesEpisode>(entityName: "SeriesEpisode")
        request.predicate = NSPredicate(format: "url IN %@", urls)
        var foundUrls: [URL] = []
        do {
            let results = try moc.fetch(request)
            for result in results {
                foundUrls.append(result.url!)
            }
        } catch {
            print(error)
            return
        }
        let toFetch = Array(Set(urls).subtracting(foundUrls))
        if toFetch.count == 0 {
            return
        }

        let ids = episodeIDs(for: toFetch)
        if ids.count > 1 {
            askedForMultipleEpisodes = true
        }

        var path = "https://rickandmortyapi.com/api/episode/"
        for id in ids {
            path.append("\(id)")
            if id != ids.last {
                path.append(",")
            }
        }
        do {
            try await self.all(resultType: ResultType.episode, url: path)
        } catch {
            print(error)
            return
        }
    }

    func episodeIDs(for urls: [URL]) -> [Int] {
        var ids: [Int] = []

        for url in urls {
            guard let last = Int(url.lastPathComponent) else { continue }
            ids.append(last)
        }
        return ids
    }
}


