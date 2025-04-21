//
//  DetailHeader.swift
//  CineTrack
//
//  Created by Michael Warner on 3/28/25.
//

import SwiftUI

struct DetailHeader: View {

    let media: VisualMedia
    
    private var posterURL: URL? { URL(string: media.posterPath) }
    
    func generateGenreString() -> String {
        return media.genres.joined(separator: ", ")
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: posterURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 180)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .overlay(
                        LinearGradient(
                            colors: [.clear, .black.opacity(0.1)],
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                    .cornerRadius(8)
            } placeholder: {
                Color.secondary.opacity(0.2)
                    .frame(width: 120, height: 180)
                    .cornerRadius(8)
            }
            
            VStack (alignment: .leading, spacing: 6) {
                Text(media.title)
                    .font(.title.bold())
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                
                let dateText: String = {
                    if let movie = media as? Movie {
                        return movie.year
                    }
                    else if let show = media as? TVShow {
                        let first = show.years.first ?? ""
                        let last = show.years.last ?? first
                        return (first == last) ? first : "\(first)-\(last)"
                    }
                    return ""
                }()
                
                Label(dateText, systemImage: "calendar")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                if let movie = media as? Movie {
                    Label("\(movie.runtime) minutes", systemImage: "clock")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                else if let show = media as? TVShow {
                    Label("\(show.numSeasons) seasons", systemImage: "tv")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Text(generateGenreString())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

