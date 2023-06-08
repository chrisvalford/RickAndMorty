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
    var charactersInfo: Info?
    var episodesInfo: Info?
    var locationsInfo: Info?

    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
        case invalidJSON
    }

    /*
     * Fetch all the decoded json records for the Result Type
     */
    func all<T: RawRepresentable>(resultType: T, url: String? = nil) async throws {
        do {
            let data = try await data(resultType: resultType, url: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            switch resultType as? ResultType {
            case .character:
                let wrapped = try decoder.decode(CharacterResults.self, from: data)
                characters = wrapped.results
                charactersInfo = wrapped.info

            case .episode:
                let wrapped = try decoder.decode(EpisodeResults.self, from: data)
                episodes = wrapped.results
                episodesInfo = wrapped.info

            case .location:
                let wrapped = try decoder.decode(LocationResults.self, from: data)
                locations = wrapped.results
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
}
