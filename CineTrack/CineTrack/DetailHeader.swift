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
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            
            VStack (alignment: .leading) {
                Text(media.title)
                    .font(.title.bold())
                    .lineLimit(2)
                    .layoutPriority(1)
                
                if let movie = media as? Movie {
                    Text(movie.year)
                } else if let show = media as? TVShow,
                          let first = show.years.first,
                          let last = show.years.last {
                    Text(first == last ? first : "\(first)-\(last)")
                }
                
                if let movie = media as? Movie {
                    Text("\(movie.runtime) minutes")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else if let show = media as? TVShow {
                    Text("\(show.numSeasons) seasons")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Text(generateGenreString())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

