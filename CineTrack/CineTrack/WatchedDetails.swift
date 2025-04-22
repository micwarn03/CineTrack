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
        
        if let date = media.dateWatched {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Text(watchedLine(for: date))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    if let thumbsUp = media.thumbsUp {
                        Image(systemName: thumbsUp
                              ? "hand.thumbsup.fill"
                              : "hand.thumbsdown.fill"
                        )
                        .foregroundStyle(thumbsUp ? .green : .red)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                if let review = media.userReview, !review.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your Review")
                            .font(.headline)
                        Text(review)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .padding(.horizontal)
        }
    }
    
    private func watchedLine(for date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        return "Watched on \(df.string(from: date))"
    }
}
