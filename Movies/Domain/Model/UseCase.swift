//
//  UseCase.swift
//  Movies
//
//  Created by Praveen on 3/3/21.
//

import Foundation

/// No Input and returns Output
protocol UseCase {
    associatedtype Output
    func execute(completion: Output)
}
/// No Input and Output
protocol CompletableUseCase {
    func execute()
}
/// Accepts Input and does not return anything
protocol CompletableUseCaseWithParameter {
    associatedtype Input
    func execute(input: Input)
}
/// Accepts Input and  return Output
protocol UseCaseWithParameter {
    associatedtype Input
    associatedtype Output
    func execute(input: Input, completion: Output)
}
