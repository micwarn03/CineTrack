//
//  ListRow.swift
//  CineTrack
//
//  Created by Michael Warner on 3/28/25.
//

import SwiftUI

struct ListRow: View {
    @State var movie: Movie?
    @State var show: TVShow?
    @State var isMovie: Bool
    
    //This will be made to look better later
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: (isMovie ? movie?.posterPath : show?.posterPath) ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            Text((isMovie ? movie?.title : show?.title) ?? "")
                .font(.title3.bold())
            Spacer()
            Text(isMovie ? "\(movie?.runtime ?? -1) minutes" : "\(show?.numSeasons ?? -1) Seasons")
                .font(.title3.bold())
        }
    }
}

#Preview {
    ListRow(movie: Movie(id: 1, title: "A Minecraft Movie", genres: ["Action"], year: "2025", runtime: 120, synopsis: "Overview", posterPath: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", mediaType: "movie"), isMovie: true)
}
