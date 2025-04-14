//
//  DetailPage.swift
//  CineTrack
//
//  Created by Michael Warner on 3/28/25.
//

import SwiftUI

struct DetailPage: View {
    
    let movie: Movie?
    let show: TVShow?
    let isMovie: Bool
    
    var body: some View {
        VStack {
            DetailHeader(movie: movie, show: show, isMovie: isMovie)
                .padding()
            Text(movie?.synopsis ?? show?.synopsis ?? "")
                .font(.body)
                .padding()
        }
    }
}

#Preview {
    DetailPage(movie: Movie(id: 1, title: "A Minecraft Movie", genres: ["Action"], year: "2025", runtime: 120, synopsis: "Overview", posterPath: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", mediaType: "movie"), show: nil, isMovie: true)
}
