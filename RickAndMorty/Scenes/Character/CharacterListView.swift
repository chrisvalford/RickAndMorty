//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import SwiftUI

struct CharacterListView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SeriesCharacter.name, ascending: true)],
        animation: .default)
    private var characters: FetchedResults<SeriesCharacter>

//    @State private var isShowingSheet = false
    @State private var searchText = ""
    @State private var sortAscending = true
    
    var body: some View {
        NavigationView {
            CharacterFilteredList(filter: searchText, sortAscending: sortAscending)
                .navigationTitle("Characters")
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            sortAscending.toggle()
                        }) {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                )
        }
        .searchable(text: $searchText, prompt: "Filter characters")
//        .sheet(isPresented: $isShowingSheet) {
//            VStack(alignment: .leading) {
//                Text("Species")
//                Text("Status") // "Alive", "Dead", "Unknown"
//                Text("Gender") // "Unknown", "Male", "Female", "Genderless"
//                Text("Origin")
//                Text("Location")
//            }
//            .presentationDetents([.medium, .large])
//        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
