//
//  LocationViewModel.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import Foundation


class LocationViewModel: ObservableObject {

    @Published var locations: [Location] = []
    let api = API()

    func fetchAllLocations() async {
        do {
            try await api.all(resultType: ResultType.location)
            locations = api.locations
        } catch {
            print(error)
        }
    }
}
