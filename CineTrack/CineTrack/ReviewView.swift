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
    @State private var draft: String
    
    var media: VisualMedia
    
    init(media: VisualMedia) {
        self.media = media
        _draft = .init(initialValue: media.userReview ?? "")
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text("Leave a Review?")
                    .font(.title2.bold())
                    .padding(.top, 16)
                
                ZStack {
                    TextEditor(text: $draft)
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.secondary, lineWidth: 1)
                        )
                        .frame(minHeight: 120, maxHeight: 200)
                        .padding(.horizontal, 16)
                    if draft.isEmpty {
                        Text("Write your review here...")
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                    }
                }
                
                
                HStack(spacing: 40) {
                    Image(systemName: media.thumbsUp == true ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(media.thumbsUp == true ? .green : .primary)
                        .scaleEffect(media.thumbsUp == true ? 1.4 : 1)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6) , value: media.thumbsUp)
                        .onTapGesture {
                            media.thumbsUp = true
                            try? context.save()
                        }
                    Image(systemName: media.thumbsUp == false ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(media.thumbsUp == false ? .red : .primary)
                        .scaleEffect(media.thumbsUp == false ? 1.4 : 1)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: media.thumbsUp)
                        .onTapGesture {
                            media.thumbsUp = false
                            try? context.save()
                        }
                    
                }
                .padding(.horizontal, 16)
                
                Button(action: {
                    media.userReview = draft
                    try? context.save()
                    dismiss()
                }) {
                    Text("Done")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
            .onDisappear {
                media.userReview = draft
                try? context.save()
            }
        }
    }
}
