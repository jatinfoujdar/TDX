//
//  Reviews.swift
//  TDX
//
//  Created by jatin foujdar on 23/11/25.
//
import Foundation

struct Review : Decodable{
    var name: String
    var comment: String
    var id: Int
    
    enum CodingKeys : String, CodingKey {
        case name = "author"
        case comment = "content"
        case id
    }
}


