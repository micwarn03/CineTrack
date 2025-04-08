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
    @State var watchHistory: [MovieDetails]
    @State var moviesList = true
    @State var searching = false
    @State var history = false
    
    var body: some View {
        NavigationStack {
            VStack{
                if !history {
                    List(moviesList ? movies : shows) { movie in
                        NavigationLink {
                            //DetailPage(movie: movie)
                        } label: {
                            ListRow(movie: movie)
                        }
                    }
                }
                else {
                    List(watchHistory) { movie in
                        NavigationLink {
                            //DetailPage(movie: movie)
                        } label: {
                            ListRow(movie: movie)
                        }
                    }
                }
                Spacer()
                //Will style to make buttons look better later 
                HStack{
                    Spacer()
                    Button("History"){
                        history.toggle()
                    }
                    Spacer()
                    Button("Add Movie"){
                        searching.toggle()
                    }
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle(history ? "Watch History" : moviesList ? "Movie Watchlist" : "TV Show Watchlist")
            .toolbar {
                Button("Switch Media Type", systemImage: "arrow.trianglehead.2.clockwise"){
                    moviesList.toggle()
                }
            }
        }
        
    }
}

#Preview {
    ContentView(movies: [MovieDetails(genres: [Genre(id:1, name:"Action")], title: "A Minecraft Movie", overview: "Overview", runtime: 120, release_date: "2020-01-01", poster_path: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", id: 1)], shows: [], watchHistory: [])
}
