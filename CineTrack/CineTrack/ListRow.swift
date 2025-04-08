//
//  ListRow.swift
//  CineTrack
//
//  Created by Michael Warner on 3/28/25.
//

import SwiftUI

struct ListRow: View {
    @State var movie: MovieDetails
    //var show: Show?
    
    //This will be made to look better later
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            Text(movie.title)
                .font(.title3.bold())
            Spacer()
            Text("\(movie.runtime) minutes")
                .font(.title3.bold())
        }
    }
}

#Preview {
    ListRow(movie: MovieDetails(genres: [Genre(id:1, name:"Action")], title: "A Minecraft Movie", overview: "Overview", runtime: 120, release_date: "2020-01-01", poster_path: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", id: 1))
}
