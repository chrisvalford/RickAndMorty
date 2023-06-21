//
//  SubheadlineView.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 21/6/23.
//

import SwiftUI

struct SubheadlineView: View {
    var title: String
    var content: String

    var body: some View {
        HStack {
            Text("\(title):")
            Text(content)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

struct SubheadlineView_Previews: PreviewProvider {
    static var previews: some View {
        SubheadlineView(title: "Title", content: "Some content")
    }
}
