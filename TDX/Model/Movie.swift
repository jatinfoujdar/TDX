//
//  Movie.swift
//  TDX
//
//  Created by jatin foujdar on 23/11/25.
//

import Foundation

struct Movie: Decodable{
    var title: String
    var releaseDate: String
    var posterPath: String
    var description: String
    var id: Int
    
    
    enum CodingKeys: String, CodingKey {
        case title = " orginal_title"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case description = "overview"
        case id
    }
}
