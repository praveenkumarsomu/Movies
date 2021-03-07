//
//  ContainerTests.swift
//  MoviesTests
//
//  Created by Praveen on 7/3/21.
//

import XCTest
@testable import Movies

class ContainerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGettingServiceClassFromGlobalContainer() {
        /// Assign
        let service = globalContainer.resolve(Service.self)
        /// Assert
        XCTAssertNotNil(service, "Service class is not registerd in globalContainer")
    }
    func testGettingMoviesRepoFromGlobalContainer() {
        /// Assign
        let service = globalContainer.resolve(MoviesRepository?.self)
        /// Assert
        // Given default value nil to silence compiler warning
        XCTAssertNotNil(service ?? nil, "MoviesRepository class is not registerd in globalContainer")
    }
    func testGettingViewModelFromSearchContainer() {
        /// Assign
        let viewModel = searchContainer.resolve(SearchViewModel?.self)
        /// Assert
        // Given default value nil to silence compiler warning
        XCTAssertNotNil(viewModel ?? nil, "MoviesRepository class is not registerd in globalContainer")
    }
    func testGettingViewModelFromMovieDetailsContainer() {
        /// Assign
        let viewModel = movieDetailsContainer.resolve(MovieDetailsViewModel?.self)
        /// Assert
        // Given default value nil to silence compiler warning
        XCTAssertNotNil(viewModel ?? nil, "MoviesRepository class is not registerd in globalContainer")
    }

}
