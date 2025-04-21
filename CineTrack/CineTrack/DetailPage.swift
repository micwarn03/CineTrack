//
//  DetailPage.swift
//  CineTrack
//
//  Created by Michael Warner on 3/28/25.
//

import SwiftUI

struct DetailPage: View {
    @Environment(\.modelContext) private var context
    @State private var showReviewSheet = false
    
    let media: VisualMedia
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    DetailHeader(media: media)
                        .padding()
                    
                    Divider()
                    
                    Text(media.synopsis)
                        .padding()
                    
                    
                    WatchedDetails(media: media)
                }
            }
            .sheet(isPresented: $showReviewSheet) {
                ReviewView(media: media)
            }
        }
        if media.dateWatched != nil {
            Button("Add / Edit Rating") {
                showReviewSheet = true
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
}
