//
//  CharacterFilteredList.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 12/6/23.
//

import SwiftUI

struct CharacterFilteredList: View {

    @FetchRequest var fetchRequest: FetchedResults<SeriesCharacter>

    init(filter: String, characterIDs: [Int32], sortAscending: Bool) {
        let sortDescriptor = SortDescriptor(\SeriesCharacter.name, order: sortAscending ? .forward : .reverse)
        var predicate: NSPredicate
        if characterIDs.isEmpty {
            predicate = filter.isEmpty ? NSPredicate(format: "name LIKE %@", "*") : NSPredicate(format: "name CONTAINS[cd] %@", filter)
        } else {
            let predicate1 = NSPredicate(format: "id IN %@", characterIDs)
            let predicate2 = filter.isEmpty ? NSPredicate(format: "name LIKE %@", "*") : NSPredicate(format: "name CONTAINS[cd] %@", filter)
            predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        }
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
        CharacterFilteredList(filter: "Rick", characterIDs: [], sortAscending: true)
    }
}
