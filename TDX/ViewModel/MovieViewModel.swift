//
//  MovieViewModel.swift
//  TDX
//
//  Created by jatin foujdar on 23/11/25.
//
import Combine
import Foundation
import SwiftUI

enum loadingState{
    case idle
    case loading
    case success
    case error(String)
}


@MainActor
class MovieViewModel: ObservableObject{
    @Published var movies: [Movie] = []
    @Published var loadingState: loadingState = .idle
    @Published var errorMessage: String = ""
    
    
    private let movieService = MovieService.shared
    
    func fetchMovies() async {
        loadingState = .loading
        
        do{
            let fetchMovies = try await movieService.fetchPopularMovies()
        }catch{
            
        }
    }
    
    
}
