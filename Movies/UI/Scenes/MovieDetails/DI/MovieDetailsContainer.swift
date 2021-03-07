//
//  MovieDetailsContainer.swift
//  Movies
//
//  Created by Praveen on 7/3/21.
//

import Foundation
import Swinject

let movieDetailsContainer: Container = {
    let container = Container()
    if let moviesRepo = globalContainer.resolve(MoviesRepository?.self), let unwrappedRepo = moviesRepo {
        container.register(MovieDetailsViewModel?.self) { resolver in
            let useCase = MovieDetailsUseCase(searchRepo: unwrappedRepo)
            let viewModel = MovieDetailsViewModel(useCase: useCase)
            return viewModel
        }
    }
    return container
}()
