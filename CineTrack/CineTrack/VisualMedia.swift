//
//  VisualMedia.swift
//  CineTrack
//
//  Created by Chris Lozinak on 4/17/25.
//

import Foundation

protocol VisualMedia : AnyObject {
    
    var id: Int32 { get }
    var title: String { get }
    var genres: [String] { get }
    var synopsis: String { get }
    var posterPath: String { get }
    var mediaType: String { get }
    var dateWatched: Date? { get set }
    var userReview: String? { get set }
    var thumbsUp: Bool? { get set }
    var dateAdded: Date? { get set }
    
}
