//
//  WatchedDetails.swift
//  CineTrack
//
//  Created by Chris Lozinak on 4/17/25.
//

import SwiftUI

struct WatchedDetails: View {
    @Environment(\.modelContext) private var context
    var media: VisualMedia
    


    var body: some View {
        if media.dateWatched == nil {
            Button("Mark as Watched") {
                media.dateWatched = Date()
                try? context.save()
            }
            .buttonStyle(.borderedProminent)

        } else {
            VStack {
                HStack {
                    Text(watchedLine(for: media.dateWatched!))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    if let thumbsUp = media.thumbsUp {
                        Image(systemName: thumbsUp ? "hand.thumbsup.fill"
                                                  : "hand.thumbsdown.fill")
                            .foregroundStyle(thumbsUp ? .green : .red)
                    }
                }

                if let review = media.userReview, !review.isEmpty {
                    Text("Your Review:")
                        .font(.headline)
                    Text(review)
                }
            }
        }
    }

    private func watchedLine(for date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        return "Watched on \(df.string(from: date))"
    }
}
