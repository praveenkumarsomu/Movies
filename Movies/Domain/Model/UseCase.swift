//
//  UseCase.swift
//  Movies
//
//  Created by Praveen on 3/3/21.
//

import Foundation

protocol UseCase {
    associatedtype Output
    func execute(completion: Output)
}

protocol CompletableUseCase {
    func execute()
}

protocol CompletableUseCaseWithParameter {
    associatedtype Input
    func execute(input: Input)
}

protocol UseCaseWithParameter {
    associatedtype Input
    associatedtype Output
    func execute(input: Input, completion: Output)
}
