//
//  ModelTests.swift
//  MoviesTests
//
//  Created by Praveen on 7/3/21.
//

import XCTest
@testable import Movies

class ModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testConvertingSearchResultsMovies() {
        let searchResult = getSearchResults()
        let url = searchResult.first?.getPosterUrl()
        XCTAssertNotNil(url, "Cannot convert poster url string into URL")
    }
    func getSearchResults() -> [Search] {
        let service = MockService()
        service.mockResponsFileName = "searchMovies"
        var searchResult: SearchResult?
        service.getMovies(model: SearchRequestModel(s: "", page: 1)) { result in
            switch result {
            case .success(let result):
                searchResult = result
            default: break
            }
        }
        return searchResult?.search ?? []
    }
}
