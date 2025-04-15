//
//  ReviewView.swift
//  CineTrack
//
//  Created by Chris Lozinak on 4/14/25.
//

import SwiftUI

struct ReviewView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    let movie: Movie?
    let show: TVShow?
    let isMovie: Bool
    
    var body: some View {
        VStack {
            Text("Your Thoughts")
                .font(.headline)
            
            if isMovie, let movie = movie {
                TextField("Your thoughts...", text: Binding (
                    get: {movie.userReview ?? "" },
                    set: {
                        movie.userReview = $0
                        try? context.save()
                    }
                ))
                .textFieldStyle(.roundedBorder)
                .padding()
                
                HStack {
                    Image(systemName: movie.thumbsUp == true ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(movie.thumbsUp == true ? .green : .primary)
                        .onTapGesture {
                            movie.thumbsUp = true
                            try? context.save()
                        }
                    Image(systemName: movie.thumbsUp == false ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(movie.thumbsUp == false ? .red : .primary)
                        .onTapGesture {
                            movie.thumbsUp = false
                            try? context.save()
                        }
                }
                .padding()
            }
            else if let show = show {
                TextField("Your thoughts...", text: Binding(
                    get: {show.userReview ?? ""},
                    set:{
                        show.userReview = $0
                        try? context.save()
                    }
                ))
                .textFieldStyle(.roundedBorder)
                .padding()
                
                HStack {
                    Image(systemName: show.thumbsUp == true ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(show.thumbsUp == true ? .green : .primary)
                        .onTapGesture {
                            show.thumbsUp = true
                            try? context.save()
                        }
                    Image(systemName: show.thumbsUp == false ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(show.thumbsUp == false ? .red : .primary)
                        .onTapGesture {
                            show.thumbsUp = false
                            try? context.save()
                        }
                }
                .padding()
            }
            Button("Done") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

#Preview {
//    ReviewView()
}
