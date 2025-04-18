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
    @State private var draft: String = ""
    
    var media: VisualMedia
    
    var body: some View {
        VStack {
            Text("Your Thoughts")
                .font(.headline)
            
            TextField("Your thoughts...", text: $draft)
                        .onAppear { draft = media.userReview ?? "" }
                        .onSubmit {
                            media.userReview = draft.isEmpty ? nil : draft
                            try? context.save()
                        }
            .textFieldStyle(.roundedBorder)
            .padding()
            
            HStack {
                Image(systemName: media.thumbsUp == true ? "hand.thumbsup.fill" : "hand.thumbsup")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(media.thumbsUp == true ? .green : .primary)
                    .onTapGesture {
                        media.thumbsUp = true
                        try? context.save()
                    }
                    .padding()
                Image(systemName: media.thumbsUp == false ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(media.thumbsUp == false ? .red : .primary)
                    .onTapGesture {
                        media.thumbsUp = false
                        try? context.save()
                    }
                    .padding()
            }
            .padding()
        }
    }
}
