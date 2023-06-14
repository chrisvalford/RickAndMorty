//
//  RickAndMortyCharacterWidget.swift
//  RickAndMortyCharacterWidget
//
//  Created by Christopher Alford on 13/6/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    var character = WidgetCharacter(id: 99, gender: "Unknown", image: URL(string: "https://rickandmortyapi.com/api/character/avatar/5.jpeg")!, location: "Earth", name: "Bob", origin: "Bognor Regis", species: "Human", status: "Alive")

    func placeholder(in context: Context) -> CharacterViewEntry {
        CharacterViewEntry(date: Date(), character: character, background: UIImage())
    }

    func getSnapshot(in context: Context, completion: @escaping (CharacterViewEntry) -> ()) {
        let entry = CharacterViewEntry(date: Date(), character: character, background: UIImage())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        RickAndMortyImageProvider.getImageFromApi(url: character.image) { image in
            var entries: [CharacterViewEntry] = []
            let policy: TimelineReloadPolicy = .after(Calendar.current.date(byAdding: .minute, value: 15, to: Date())!)
            let entry = CharacterViewEntry(date: Date(), character: character, background: image)
            entries.append(entry)
            let timeline = Timeline(entries: entries, policy: policy)
            completion(timeline)
        }
    }
}

struct CharacterViewEntry: TimelineEntry {
    let date: Date
    let character: WidgetCharacter
    let background: UIImage
}

struct RickAndMortyCharacterWidgetEntryView : View {
    let entry: CharacterViewEntry
    var body: some View {
        CharacterWidgetView(character: entry.character, image: Image(uiImage: entry.background))
    }
}

struct RickAndMortyCharacterWidget: Widget {
    let kind: String = "RickAndMortyCharacterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RickAndMortyCharacterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct RickAndMortyCharacterWidget_Previews: PreviewProvider {
    static let character = WidgetCharacter(id: 99, gender: "Unknown", image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!, location: "Earth", name: "Bob", origin: "Bognor Regis", species: "Human", status: "Alive")

    static var previews: some View {
        RickAndMortyCharacterWidgetEntryView(entry: CharacterViewEntry(date: Date(), character: character, background: UIImage()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
