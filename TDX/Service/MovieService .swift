//
//  MovieService .swift
//  TDX
//
//  Created by jatin foujdar on 23/11/25.
//
import Foundation


enum MovieAPIError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode data"
        }
    }
}

class MovieService {
    
    private let apiKey = "0f11b9f739cc213a2f034673163e2dc0"
    private let baseURL = "https://api.themoviedb.org/3"
    
    
    func fetchPopularMovies() async throws -> [Movie] {
        
        guard let url = URL(string: "\(baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=1") else {
            throw MovieAPIError.invalidURL
        }
        
        let (data , response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else  {
            throw MovieAPIError.noData
        }
        
        do{
            let jsonResult = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            let resultsData = try JSONSerialization.data(withJSONObject: jsonResult?["results"] ?? [])
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movies = try decoder.decode([Movie].self, from: resultsData)
            return movies
        }catch{
            throw MovieAPIError.decodingError
        }
    }
    
    func fetchMovie(by id: Int) async throws -> [Movie] {
        
        guard let url = URL(string: "\(baseURL)/movie/\(id)?api_key=\(apiKey)&language=en-US")else{
            throw MovieAPIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else{
            throw MovieAPIError.noData
        }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movies = try decoder.decode([Movie].self, from: data)
            return movies
        } catch {
            throw MovieAPIError.decodingError
        }
    }
    
    func buildImageURL(path: String?, size: String = "w500") -> URL? {
        guard let path = path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size)\(path)")
    }
    
}
