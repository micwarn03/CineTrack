//
//  ContentView.swift
//  CineTrack
//
//  Created by Shea Leech on 3/28/25.
//

import SwiftUI

struct ContentView: View {
    @State var movies: [Movie]
    @State var shows: [TVShow]
    @State var moviesList = true
    
    var body: some View {
        NavigationStack {
            if moviesList {
                VStack{
                    List(movies, id: \.self) { movie in
                        NavigationLink {
                            DetailPage(movie: movie)
                        } label: {
                            ListRow(movie: movie)
                        }
                    }
                }
                .navigationTitle("Movie Watchlist")
                .toolbar {
                    Button("Switch Media Type", systemImage: "plus", action: addBook)
                }
            }
            else {
                List(shows, if: \.self) { show in
                    NavigationLink {
                        DetailPage(show: show)
                    } label: {
                        ListRow(show: show)
                    }
                }
                .navigationTitle("TV Show Watchlist")
            }
        }
    }
}

#Preview {
    ContentView()
}
