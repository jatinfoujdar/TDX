//
//  Movie.swift
//  TDX
//
//  Created by jatin foujdar on 23/11/25.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie {
   
    static let sampleMovies = [
        Movie(
            id: 1,
            title: "Inception",
            overview: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
            posterPath: "/oYu113G8PXRqfNQb4JMRueQ68Y4.jpg",
            backdropPath: "/s3TBrRGB1iav7gFOCNx3H31MoES.jpg",
            releaseDate: "2010-07-15",
            voteAverage: 8.4,
            voteCount: 30000
        ),
        Movie(
            id: 2,
            title: "The Matrix",
            overview: "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.",
            posterPath: "/hEpWvX6BpKOHTReeXo2K1H9VHw6.jpg",
            backdropPath: "/bWtlQYAuPcLZTxIY8fVZ7UrzZrP.jpg",
            releaseDate: "1999-03-30",
            voteAverage: 8.2,
            voteCount: 25000
        ),
        Movie(
            id: 3,
            title: "Interstellar",
            overview: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
            posterPath: "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
            backdropPath: "/xu9zaAevzQ5nnrsXN6JcahLnG4i.jpg",
            releaseDate: "2014-11-05",
            voteAverage: 8.6,
            voteCount: 28000
        )
    ]
}
