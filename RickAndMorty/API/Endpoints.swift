//
//  Endpoints.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 7/6/23.
//

import Foundation

let basePath = "https://rickandmortyapi.com/api"

enum ResultType: String {
    case character, episode, location
}

/*
 All GET requests

 All requests follow the same format:
 basePath/ResultType/           for All results
 basePath/ResultType/Int        for Specific record
 basePath/ResultType/Int,Int... for a Selection of records

 Filters:
All requests can be filtered by appending
 /?parameter=rick&parameter=alive...

 Remember to encode spaces to %20

 character - Available parameters:
 name: filter by the given name.
 status: filter by the given status (alive, dead or unknown).
 species: filter by the given species.
 type: filter by the given type.
 gender: filter by the given gender (female, male, genderless or unknown).

 location - Available parameters:
 name: filter by the given name, partial name "Sanchez" will give whole family
 type: filter by the given type.
 dimension: filter by the given dimension.

 episode - Available parameters:
 name: filter by the given name.
 episode: filter by the given episode code.

Only request a specific page if the results return a pages count of > 1
 https://rickandmortyapi.com/api/character/?page=19

 No results error:
 {"error":"There is nothing here"}
 */
