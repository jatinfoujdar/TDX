//
//  ContentView.swift
//  TDX
//
//  Created by jatin foujdar on 23/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieViewModel()
    @State private var searchText: String = ""
//    @State private var isSearchFocused: Bool
//    @State private var recentSearches : [String] = []
    
    var body: some View {
        NavigationStack {
                        
            content
                .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always),prompt: "Search..." )
                .onChange(of: searchText){
                    Task{
                        if searchText.isEmpty{
                            await viewModel.fetchMovies()
                        }else{
                            await viewModel.searchMovies(query: searchText)
                        }
                    }
                }
                .navigationTitle("Popular Movies")
        }
    }
    
    
    @ViewBuilder
    private var content : some View{
        switch viewModel.loadingState {
        case .idle, .loading:
            ProgressView()
                .task {
                    await viewModel.fetchMovies()
                }

        case .success:
            
            List(viewModel.movies) { movie in
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.releaseDate)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
           
            
            
        case .error(let message):
            VStack(spacing: 12) {
                Text("Something went wrong")
                    .font(.headline)

                Text(message)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Button("Retry") {
                    Task {
                        await viewModel.fetchMovies()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}



#Preview {
    ContentView()
}
