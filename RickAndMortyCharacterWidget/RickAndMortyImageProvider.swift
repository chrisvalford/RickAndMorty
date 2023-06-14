//
//  ApodImageProvider.swift
//  ApodWidgetExtension
//
//  Created by SchwiftyUI on 12/7/20.
//

import Foundation
import SwiftUI

enum RickAndMortyImageResponse {
    case Success(image: UIImage, title: String)
    case Failure
}

struct RickAndMortyApiResponse: Decodable {
    var url: String
    var title: String
}

class RickAndMortyImageProvider {
    static func getImageFromApi(url: URL, completion: @escaping (UIImage) -> Void) {
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else {
                completion(UIImage(systemName: "wifi.exclamationmark")!)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(UIImage(systemName: "wifi.exclamationmark")!)
                return
            }
            completion(image)
        }
        task.resume()
    }
}
