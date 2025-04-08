//
//  Search.swift
//  CineTrack
//
//  Created by Michael Warner on 4/8/25.
//

import SwiftUI

struct Search: View {
    @Environment(\.dismiss) var dismiss
    @State var searchText = ""
    @State var results: [result] = []
    @State var movieResults: [MovieDetails] = []
    @State var showResults: [TVSeriesDetails] = []
    @Binding var movieList: [Movie]
    @Binding var showList: [TVShow]
    @State var movies: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                TextField("Search...", text: $searchText)
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
            if movies {
                List(movieResults) { result in
                    let movie = convertMovieResult(result: result)
                    Button {
                        movieList.append(movie)
                        dismiss()
                    } label : {
                        ListRow(movie: movie, isMovie: true)
                    }
                }
            }
            else {
                List(showResults) { result in
                    let show = convertTVResult(result: result)
                    Button {
                        showList.append(show)
                        dismiss()
                    } label : {
                        ListRow(show: show, isMovie: false)
                    }
                }
            }
        }
    }
}

#Preview {
    //Search(results: [])
}
