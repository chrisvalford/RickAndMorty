//
//  CharacterFilteredList.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 12/6/23.
//

import SwiftUI

struct CharacterFilteredList: View {

    @FetchRequest var fetchRequest: FetchedResults<SeriesCharacter>

    init(filter: String, sortAscending: Bool) {
        let sortDescriptor = SortDescriptor(\SeriesCharacter.name, order: sortAscending ? .forward : .reverse)
        let predicate = filter.isEmpty ? NSPredicate(format: "name LIKE %@", "*") : NSPredicate(format: "name CONTAINS %@", filter)
        _fetchRequest = FetchRequest<SeriesCharacter>(sortDescriptors: [sortDescriptor],
                                                      predicate: predicate)
    }

    var body: some View {
        List (fetchRequest, id: \.self) { character in
            NavigationLink(destination: CharacterDetailView(character: character)) {
                CharacterListCell(character: character)
                    .frame(height: 100)
                    .listRowSeparator(.hidden)
            }
        }
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.horizontal)
        .listStyle(PlainListStyle())
    }
}

struct CharacterFilteredList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterFilteredList(filter: "Rick", sortAscending: true)
    }
}
