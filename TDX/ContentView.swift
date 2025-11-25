//
//  ContentView.swift
//  TDX
//
//  Created by jatin foujdar on 23/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.loadingState {
                case .idle, .loading:
                    ProgressView()
                        .task {
                            await viewModel.fetchMovies()
                        }

                case .success:
                    List(viewModel.movies) { movie in   // or: List(viewModel.movies, id: \.id)
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
            .navigationTitle("Popular Movies")
        }
    }
}

#Preview {
    ContentView()
}
