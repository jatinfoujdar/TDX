//
//  Cast.swift
//  TDX
//
//  Created by jatin foujdar on 23/11/25.
//

import Foundation

struct Cast: Decodable{
    var realName: String
    var fictionalName: String
    var posterPath: String
    var id: Int
    
    
    enum CodingKeys: String, CodingKey {
        case realName = "original_name"
        case fictionalName = "character"
        case posterPath = "profile_path"
        case id
    }
}
