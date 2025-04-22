//
//  ListRow.swift
//  CineTrack
//
//  Created by Michael Warner on 3/28/25.
//

import SwiftUI

struct ListRow: View {
    let media: VisualMedia
    let isMovie: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: media.posterPath)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width:100)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            VStack (alignment: .leading) {
                Text(media.title)
                    .font(.title2)
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
                
               Text(dateText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if isMovie, let movie = media as? Movie {
                    Text("\(movie.runtime) min")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } else if let show = media as? TVShow {
                    Text("\(show.numSeasons) seasons")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            if let thumbs = media.thumbsUp {
                Image(systemName: thumbs
                      ? "hand.thumbsup.fill"
                      : "hand.thumbsdown.fill"
                )
                .imageScale(.large)
                .foregroundColor(thumbs ? .green : .red)
                .padding(.top, 4)
            }
        }
    }
}



//#Preview {
//    ListRow(movie: Movie(id: 1, title: "A Minecraft Movie", genres: ["Action"], year: "2025", runtime: 120, synopsis: "Overview", posterPath: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", mediaType: "movie"), isMovie: true)
//}
