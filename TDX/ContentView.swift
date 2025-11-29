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
    @State private var isSearchFocused: Bool = false
    @State private var recentSearches : [String] = []
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top){
                content
                
                if isSearchFocused && searchText.isEmpty && !recentSearches.isEmpty{
                    RecentSearchesView(items: recentSearches, onSelect: { selectedTerm in
                        searchText = selectedTerm
                        isSearchFocused = true
                        Task{
                            await viewModel.searchMovies(query: selectedTerm)
                        }
                    }, onClear:{
                        SearchHistoryManager.shared.clearHistory()
                        recentSearches = []
                    })
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    .zIndex(1)
                }
            }
            .navigationTitle("Popular Movies")
        }
        .searchable(text: $searchText,
                    isPresented: $isSearchFocused,
                    placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: "Search....")
        .onSubmit(of: .search) {
            Task{
                await viewModel.searchMovies(query: searchText)
            }
            SearchHistoryManager.shared.addSearch(searchText)
            recentSearches = SearchHistoryManager.shared.getRecentSearches()
        }
        .onChange(of: searchText){ newValue in
            if newValue.isEmpty{
                Task{
                    await viewModel.fetchMovies()
                }
            }
        }
        .onAppear{
            recentSearches = SearchHistoryManager.shared.getRecentSearches()
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
