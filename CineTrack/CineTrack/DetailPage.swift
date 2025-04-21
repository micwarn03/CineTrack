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
                VStack (spacing: 16) {
                    DetailHeader(media: media)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(media.synopsis)
                            .font(.body)
                            .foregroundStyle(Color.primary)
                            .padding()
                        
                        WatchedDetails(media: media)
                    }
                }
                .padding(.vertical)
            }
            .sheet(isPresented: $showReviewSheet) {
                ReviewView(media: media)
            }
            if media.dateWatched == nil {
                Spacer()
                Button("Mark as Watched") {
                    media.dateWatched = Date()
                    try? context.save()
                    showReviewSheet = true
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 30)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                if media.dateWatched != nil {
                    Button {
                        showReviewSheet = true
                    } label: {
                        Label("Review", systemImage: "star.bubble")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
}
