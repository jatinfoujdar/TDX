//
//  MovieViewModel.swift
//  TDX
//
//  Created by jatin foujdar on 23/11/25.
//
import Combine
import Foundation
import SwiftUI

enum LoadingState{
    case idle
    case loading
    case success
    case error(String)
}


@MainActor
class MovieViewModel: ObservableObject{
    @Published var movies: [Movie] = []
    @Published var loadingState: LoadingState = .idle
    @Published var errorMessage: String = ""
    
    
    private let movieService = MovieService.shared
    
    func fetchMovies() async {
        loadingState = .loading
        
        do{
            let fetchMovies = try await movieService.fetchPopularMovies()
            
            movies = fetchMovies
            loadingState = .success
        }catch{
            errorMessage = error.localizedDescription
            loadingState = .error(error.localizedDescription)
        }
    }
    
    func getImageURL(path: String?, size: String = "w500") -> URL? {
        return movieService.buildImageURL(path: path, size: size)
    }
    
    func searchMovies(query: String) async{
        guard !query.isEmpty else{
            await fetchMovies()
            return
        }
        loadingState = .loading
        
        do{
            let searchResults = try await movieService.searchMovie(query: query)
            movies = searchResults
            loadingState = .success
        }catch{
            errorMessage = error.localizedDescription
            loadingState = .error(error.localizedDescription)
        }
    }
    
    func getMovieDetail(movieId: Int) async -> Movie? {
        do {
            let movie = try await movieService.fetchMovie(by: movieId)
            return movie
        } catch {
            print("Error fetching movie detail: \(error)")
            return nil
        }
    }
}
    
    
    struct MovieViewModel_Previews: PreviewProvider {
        static var previews: some View {
            // Create a preview instance with sample data
            let viewModel = MovieViewModel()
            viewModel.movies = Movie.sampleMovies
            viewModel.loadingState = .success
            
            return ContentView()
                .environmentObject(viewModel)
        }
    }
    

