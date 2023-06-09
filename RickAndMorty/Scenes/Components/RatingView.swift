//
//  RatingView.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 9/6/23.
//

import SwiftUI

struct RatingView: View {

    @Binding var rating: Int
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow

    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }

    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        // Remove rating if rating is already 1
                        if number == 1 && rating == 1 {
                            rating = 0
                        } else {
                            rating = number
                        }
                    }
            }
        }
        .padding(.bottom, 4)
    }
}

struct RatingView_Previews: PreviewProvider {

    @State static var rating = 4
    static var previews: some View {
        RatingView(rating: $rating)
    }
}
