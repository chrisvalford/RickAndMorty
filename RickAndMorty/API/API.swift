//
//  API.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import Foundation

public enum ResultType: String, Codable {
    case character, episode, location
}

class API {

    var characters: [Character] = []
    var episodes: [Episode] = []
    var locations: [Location] = []

    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
        case invalidJSON
    }

    //TODO: Check against device 12/24 Hr clock
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }

    /*
     * Fetch the data for the specified ResultType
     */
    private func data<T>(resultType: T) async throws -> Data {
        guard let url = URL(string: basePath+(resultType as! ResultType).rawValue) else {
            throw APIError.invalidURL
        }
        print("URL: \(url.absoluteString)")
        let (data, response) = try await URLSession.shared.data(from: url)
        let success = 200..<299 ~= (response as? HTTPURLResponse)?.statusCode ?? 0
        if success == false {
            throw APIError.invalidResponse
        }
        return data
    }

    /*
     * Fetch all the decoded json records for the Result Type
     */
    func all<T: RawRepresentable>(resultType: T) async throws {
        do {
            let data = try await data(resultType: resultType)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            switch resultType as? ResultType {
            case .character:
                let wrapped = try decoder.decode(CharacterResults.self, from: data)
                characters = wrapped.results

            case .episode:
                let wrapped = try decoder.decode(EpisodeResults.self, from: data)
                episodes = wrapped.results

            case .location:
                let wrapped = try decoder.decode(LocationResults.self, from: data)
                locations = wrapped.results
            default:
                throw APIError.invalidJSON
            }
        } catch {
            print(error)
            throw APIError.invalidJSON
        }
    }
}
