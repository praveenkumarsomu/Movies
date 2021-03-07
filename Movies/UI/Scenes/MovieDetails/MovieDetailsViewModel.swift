//
//  ViewModel.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import Foundation

protocol MovieDetailsViewModelInput {
    func getMovieDetails(for imdbID: String)
}
protocol MovieDetailsViewModelOutput {
    var updateMovieDetails: ((MovieDetailsModel) -> Void) { get set }
    var updateMovieDetailsError: ((String) -> Void) { get set }
}
typealias MovieDetailsViewModelProtocol = MovieDetailsViewModelInput & MovieDetailsViewModelOutput

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    var movieDetailsUseCase: MovieDetailsUseCase!
    // MARK:- Outputs
    var updateMovieDetails: ((MovieDetailsModel) -> Void) = { _ in }
    var updateMovieDetailsError: ((String) -> Void) = { _ in }

    init(useCase: MovieDetailsUseCase) {
        self.movieDetailsUseCase = useCase
    }
    // MARK:- Inputs
    func getMovieDetails(for imdbID: String) {
        movieDetailsUseCase.execute(input: imdbID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieDetails):
                self.updateMovieDetails(movieDetails)
            case .failure(let error):
                self.updateMovieDetailsError(error.localizedDescription)
            }
        }
    }
    
}
