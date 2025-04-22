//
//  Search.swift
//  CineTrack
//
//  Created by Michael Warner on 4/8/25.
//

import SwiftUI
import SwiftData

struct Search: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @Query var allMovies: [Movie]
    @Query var allTVShows: [TVShow]
    
    @State var searchText = ""
    @State var results: [result] = []
    @State var movieResults: [MovieDetails] = []
    @State var showResults: [TVSeriesDetails] = []
    
    @State var movies: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                TextField("Search...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                Button("Search", systemImage: "magnifyingglass"){
                    movieResults = []
                    showResults = []
                    Task {
                        results = movies ? (await searchForMovies(query: searchText) ?? []) : (await searchForTV(query: searchText) ?? [])
                        if movies {
                            for result in results {
                                if let movie = await getMovieByID(id: result.id){
                                    movieResults.append(movie)
                                }
                            }
                        }
                        else {
                            for result in results {
                                if let show = await getTVSeriesByID(id: result.id){
                                    showResults.append(show)
                                }
                            }
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            if movies {
                let existingMovieIDs = Set(allMovies.map(\.id))
                
                List(movieResults.filter { !existingMovieIDs.contains($0.id) }) { result in
                    let movie = convertMovieResult(result: result)
                    Button {
                        movie.dateAdded = .now
                        context.insert(movie)
                        try? context.save()
                        dismiss()
                    } label : {
                        ListRow(media: movie, isMovie: true)
                    }
                }
            }
            else {
                let existingShowIDs = Set(allTVShows.map(\.id))
                
                List(showResults.filter { !existingShowIDs.contains($0.id) }) { result in
                    let show = convertTVResult(result: result)
                    Button {
                        show.dateAdded = .now
                        context.insert(show)
                        try? context.save()
                        dismiss()
                    } label : {
                        ListRow(media: show, isMovie: false)
                    }
                }
            }
        }
    }
}
