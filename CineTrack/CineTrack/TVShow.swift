//
//  TVShow.swift
//  CineTrack
//
//  Created by Chris Lozinak on 3/28/25.
//

import Foundation
import SwiftData

@Model
class TVShow : Identifiable {
    var id: Int32
    var title: String
    var genres: [String]
    var years: [String]
    var synopsis: String
    var posterPath: String
    var mediaType: String
    var numSeasons: Int
    var dateWatched: Date? = nil
    var userReview: String? = nil
    var thumbsUp: Bool? = nil
    
    init(id: Int32, title: String, genres: [String], years: [String], synopsis: String, posterPath: String, mediaType: String, numSeasons: Int) {
        self.id = id
        self.title = title
        self.genres = genres
        self.years = years
        self.synopsis = synopsis
        self.posterPath = posterPath
        self.mediaType = mediaType
        self.numSeasons = numSeasons
    }
}
