//
//  ContentView.swift
//  CineTrack
//
//  Created by Shea Leech on 3/28/25.
//

import SwiftUI

struct ContentView: View {
    @State var movies: [MovieDetails]
    @State var shows: [MovieDetails]
    @State var moviesList = true
    @State var searching = false
    
    var body: some View {
        NavigationStack {
            VStack{
                List(moviesList ? movies : shows) { movie in
                    NavigationLink {
                        //DetailPage(movie: movie)
                    } label: {
                        //ListRow(movie: movie)
                    }
                }
                Spacer()
                Button("Add Movie"){
                    searching.toggle()
                }
            }
            .navigationTitle(moviesList ? "Movie Watchlist" : "TV Show Watchlist")
            .toolbar {
                Button("Switch Media Type", systemImage: "arrow.trianglehead.2.clockwise"){
                    moviesList.toggle()
                }
            }
        }
        
    }
}

#Preview {
    ContentView(movies: [], shows: [])
}
