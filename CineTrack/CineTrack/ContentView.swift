//
//  ContentView.swift
//  CineTrack
//
//  Created by Shea Leech on 3/28/25.
//

import SwiftUI
import SwiftData

enum SortOption: String, CaseIterable, Identifiable {
    case aToZ = "A → Z"
    case zToA = "Z → A"
    case newToOld = "Newest → Oldest"
    case oldToNew = "Oldest → Newest"
    case runtimeAscending = "Runtime ↑"
    case runtimeDescending = "Runtime ↓"
    
    var id: String { rawValue }
}

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @Query var allMovies: [Movie]
    @Query var allTVShows: [TVShow]
    
    @State var moviesList = true
    @State var searching = false
    @State var history = false
    
    @State private var sortOption: SortOption = .aToZ
    @State private var selectedGenres: Set<String> = []
    
    @AppStorage("firstLaunch") var firstLaunch = true
    
    func deleteMovie(_ indexSet: IndexSet) {
        for index in indexSet {
            context.delete(allMovies[index])
        }
    }
    
    func deleteShow(_ indexSet: IndexSet) {
        for index in indexSet {
            context.delete(allTVShows[index])
        }
    }
    
    private var availableGenres: [String] {
        let raw = moviesList
        ? allMovies.flatMap(\.genres)
        : allTVShows.flatMap(\.genres)
        return Array(Set(raw)).sorted()
    }
    
    private var sortedMovies: [Movie] {
        var list = allMovies.filter {
            history ? $0.dateWatched != nil : $0.dateWatched == nil
        }
        if !selectedGenres.isEmpty {
            list = list.filter {
                !Set($0.genres).isDisjoint(with: selectedGenres)
            }
        }
        switch sortOption {
            case .aToZ:
                return list.sorted {
                    $0.title.localizedLowercase < $1.title.localizedLowercase
                }
            case .zToA:
                return list.sorted {
                    $0.title.localizedLowercase > $1.title.localizedLowercase
                }
            case .newToOld:
                return list.sorted {
                    (Int($0.year) ?? 0) > (Int($1.year) ?? 0)
                }
            case .oldToNew:
                return list.sorted {
                    (Int($0.year) ?? 0) < (Int($1.year) ?? 0)
                }
            case .runtimeAscending:
                return list.sorted {
                    $0.runtime < $1.runtime
                }
            case .runtimeDescending:
                return list.sorted {
                    $0.runtime > $1.runtime
                }
        }
    }
    
    private var sortedShows: [TVShow] {
        var list = allTVShows.filter {
            history ? $0.dateWatched != nil : $0.dateWatched == nil
        }
        if !selectedGenres.isEmpty {
            list = list.filter {
                !Set($0.genres).isDisjoint(with: selectedGenres)
            }
        }
        switch sortOption {
            case .aToZ:
                return list.sorted {
                    $0.title.localizedLowercase < $1.title.localizedLowercase
                }
            case .zToA:
                return list.sorted {
                    $0.title.localizedLowercase > $1.title.localizedLowercase
                }
            case .newToOld:
                return list.sorted {
                    (Int($0.years.last ?? "") ?? 0) > (Int($1.years.last ?? "") ?? 0)
                }
            case .oldToNew:
                return list.sorted {
                    (Int($0.years.last ?? "") ?? 0) < (Int($1.years.last ?? "") ?? 0)                }
            case .runtimeAscending:
                return list.sorted {
                    $0.numSeasons < $1.numSeasons
                }
            case .runtimeDescending:
                return list.sorted {
                    $0.numSeasons > $1.numSeasons
                }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if !history {
                    if (moviesList) {
                        List {
                            ForEach(sortedMovies) { movie in
                                NavigationLink {
                                    DetailPage(media: movie)
                                } label: {
                                    ListRow(movie: movie, isMovie: true)
                                }
                            }
                            .onDelete(perform: deleteMovie)
                        }
                    }
                    else {
                        List {
                            ForEach(sortedShows) { show in
                                NavigationLink {
                                    DetailPage(media: show)
                                } label: {
                                    ListRow(show: show, isMovie: false)
                                }
                            }
                            .onDelete(perform: deleteShow)
                        }
                    }
                }
                else {
                    if (moviesList) {
                        List(sortedMovies) { movie in
                            NavigationLink {
                                DetailPage(media: movie)
                            } label: {
                                ListRow(movie: movie, isMovie: true)
                            }
                        }
                    }
                    else {
                        List(sortedShows) { show in
                            NavigationLink {
                                DetailPage(media: show)
                            } label: {
                                ListRow(show: show, isMovie: false)
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle(history ? (moviesList ? "Movie Watch History" : "TV Show Watch History") : moviesList ? "Movie Watchlist" : "TV Show Watchlist")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Switch Media Type", systemImage: "arrow.trianglehead.2.clockwise"){
                        moviesList.toggle()
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Picker("", selection: $history) {
                        Label("Watchlist", systemImage: "list.bullet").tag(false)
                        Label("History",   systemImage: "clock.arrow.circlepath").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .controlSize(.large)
                    .foregroundStyle(.blue)
                    
                    Spacer()
                    
                    NavigationLink {
                        Search(movies: moviesList)
                    } label: {
                        Label("Search", systemImage: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    
                    Spacer()
                    
                    Menu {
                        Section("Sort") {
                            ForEach(SortOption.allCases) { option in
                                Button(option.rawValue) { sortOption = option }
                            }
                        }
                        
                        Section("Filter") {
                            Menu("By Genre…") {
                                ForEach(availableGenres, id: \.self) { genre in
                                    Button {
                                        if selectedGenres.contains(genre) {
                                            selectedGenres.remove(genre)
                                        } else {
                                            selectedGenres.insert(genre)
                                        }
                                    } label: {
                                        HStack {
                                            Text(genre)
                                            Spacer()
                                            if selectedGenres.contains(genre) {
                                                Image(systemName: "checkmark")
                                            }
                                        }
                                    }
                                }
                                Divider()
                                Button("Clear Genres") {
                                    selectedGenres.removeAll()
                                }
                            }
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
            }
            .sheet(isPresented:$firstLaunch){
                IntroSheet(firstLaunch: $firstLaunch)
            }
            .accentColor(.blue)
        }
    }
}
    
