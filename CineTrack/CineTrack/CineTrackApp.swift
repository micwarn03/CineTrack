//
//  CineTrackApp.swift
//  CineTrack
//
//  Created by Shea Leech on 3/28/25.
//

import SwiftUI
import SwiftData

@main
struct CineTrackApp: App {
        
    var body: some Scene {
        WindowGroup {
            ContentView(/*movies: [], shows: [], movieHistory: [], showHistory: []*/)
        }
        .modelContainer(for: [Movie.self, TVShow.self])
    }
}
