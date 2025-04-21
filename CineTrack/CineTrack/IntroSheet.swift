//
//  TutorialSheet.swift
//  CineTrack
//
//  Created by Shea Leech on 4/15/25.
//

import SwiftUI

struct IntroSheet: View {
    
    @Binding var firstLaunch:Bool
    
    var body: some View {
        VStack{
            Text("Welcome to CineTrack!")
                .font(.title)
            Spacer()
            Text("Because it is your first time using the app, you are being shown this brief introduction (and disclaimer). As you might have guessed from the name, CineTrack is a platform for tracking movies and TV shows you have watched or want to watch in the future. It features a separate watchlist for movies and TV shows and you can easily swap between them with the switch button in the top right corner. To get started adding things, simply tap the search button (+), search up something, and tap on a result to add it to your watch list. From there things should be simple and intuitive and we hope you will enjoy using CineTrack!")
                .multilineTextAlignment(.center)
            Spacer()
            Divider()
            Spacer()
            Image("tmdb_logo")
            Text("This product uses the TMDB API but is not endorsed or certified by TMDB.")
                .multilineTextAlignment(.center)
            Button("Dismiss"){
                firstLaunch = false
            }
        }
        .padding()
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    @Previewable @State var firstLaunch = true
    IntroSheet(firstLaunch: $firstLaunch)
}
