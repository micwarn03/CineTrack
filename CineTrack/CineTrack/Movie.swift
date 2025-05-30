//
//  Movie.swift
//  CineTrack
//
//  Created by Chris Lozinak on 3/28/25.
//

import Foundation
import SwiftData

@Model
class Movie : Identifiable, VisualMedia {
    var id: Int32
    var title: String
    var genres: [String]
    var year: String
    var runtime: Int
    var synopsis: String
    var posterPath: String
    var mediaType: String
    var dateWatched: Date? = nil
    var userReview: String? = nil
    var thumbsUp: Bool? = nil
    var dateAdded: Date? = nil
    
    init(id: Int32, title: String, genres: [String], year: String, runtime: Int, synopsis: String, posterPath: String, mediaType: String) {
        self.id = id
        self.title = title
        self.genres = genres
        self.year = year
        self.runtime = runtime
        self.synopsis = synopsis
        self.posterPath = posterPath
        self.mediaType = mediaType
    }
}
