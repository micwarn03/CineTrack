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
    
    let movie: Movie?
    let show: TVShow?
    let isMovie: Bool
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    DetailHeader(movie: movie, show: show, isMovie: isMovie)
                        .padding()
                    Text(movie?.synopsis ?? show?.synopsis ?? "")
                        .font(.body)
                        .padding()
                    
                    if isMovie, let movie = movie {
                        if movie.dateWatched == nil {
                            Button("Mark as Watched") {
                                movie.dateWatched = Date()
                                try? context.save()
                            }
                            .buttonStyle(.borderedProminent)
                        } else {
                            HStack {
                                Text("Watched on \(formatDate(movie.dateWatched))")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                if let thumbsUp = movie.thumbsUp {
                                    if thumbsUp {
                                        Image(systemName: "hand.thumbsup.fill")
                                            .foregroundStyle(.green)
                                    } else {
                                        Image(systemName: "hand.thumbsdown.fill")
                                            .foregroundStyle(.red)
                                    }
                                } else {
                                    Spacer()
                                }
                            }
                            if let review = movie.userReview, !review.isEmpty {
                                Text("Your Review: \(review)")
                                    .padding()
                            }
                        }
                    }
                    
                    else if let show = show {
                        if show.dateWatched == nil {
                            Button("Mark as Watched") {
                                show.dateWatched = Date()
                                try? context.save()
                            }
                            .buttonStyle(.borderedProminent)
                        } else {
                            HStack {
                                Text("Watched on \(formatDate(show.dateWatched))")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                if let thumbsUp = show.thumbsUp {
                                    if thumbsUp {
                                        Image(systemName: "hand.thumbsup.fill")
                                            .foregroundStyle(.green)
                                    } else {
                                        Image(systemName: "hand.thumbsdown.fill")
                                            .foregroundStyle(.red)
                                    }
                                } else {
                                    Spacer()
                                }
                            }
                            
                            if let review = show.userReview, !review.isEmpty {
                                Text("Your Review:")
                                Text("\(review)")
                                    .padding()
                            }
                        }
                    }
                    
                }
            }
            .sheet(isPresented: $showReviewSheet) {
                ReviewView(movie: movie, show: show, isMovie: isMovie)
            }
        }
        Button("Add / Edit Rating") {
            showReviewSheet = true
        }
        .buttonStyle(.borderedProminent)
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
}

#Preview {
    DetailPage(movie: Movie(id: 1, title: "A Minecraft Movie", genres: ["Action"], year: "2025", runtime: 120, synopsis: "Overview", posterPath: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", mediaType: "movie"), show: nil, isMovie: true)
}
