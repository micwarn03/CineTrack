//
//  DetailHeader.swift
//  CineTrack
//
//  Created by Michael Warner on 3/28/25.
//

import SwiftUI

struct DetailHeader: View {

    let movie: Movie?
    let show: TVShow?
    var isMovie: Bool
    
    func generateGenreString() -> String {
        return movie?.genres.joined(separator: ", ") ?? ""
    }
    
    var showYearRange: String {
        guard let show = show,
              let first = show.years.first,
              let last = show.years.last else {
            return ""
        }
        
        if first == last {
            return "\(first)"
        } else {
            return "\(first)-\(last)"
        }
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: (isMovie ? movie?.posterPath : show?.posterPath) ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 180)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            
            VStack (alignment: .leading) {
                Text((isMovie ? movie?.title : show?.title) ?? "")
                    .font(.title)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .layoutPriority(1)
                Text(isMovie ? (movie?.year ?? "") : showYearRange)
                Text(isMovie ? "\(movie?.runtime ?? -1) minutes" : "\(show?.numSeasons ?? -1) Seasons")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(generateGenreString())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    DetailHeader(movie: Movie(id: 1, title: "A Minecraft Movie", genres: ["Action"], year: "2025", runtime: 120, synopsis: "Overview", posterPath: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", mediaType: "movie"), show: nil, isMovie: true)
}
