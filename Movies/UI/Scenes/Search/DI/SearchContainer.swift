//
//  SearchContainer.swift
//  Movies
//
//  Created by Praveen on 4/3/21.
//

import Foundation
import Swinject

/// Search scene container, all necessary classes, value types for this scene will be registered here
let searchContainer: Container = {
    let container = Container()
    if let moviesRepo = globalContainer.resolve(MoviesRepository?.self), let unwrappedRepo = moviesRepo {
        container.register(SearchViewModel?.self) { resolver in
            let useCase = SearchMoviesUseCase(searchRepo: unwrappedRepo)
            let viewModel = SearchViewModel(usecase: useCase)
            return viewModel
        }
    }
    return container
}()
