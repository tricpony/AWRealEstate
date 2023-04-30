//
//  MasterViewModelTests.swift
//  AWRealEstateTests
//
//  Created by aarthur on 4/29/23.
//

import XCTest
@testable import AWRealEstate

final class MasterViewModelTests: XCTestCase {

    func testSuccessfulFetch() {
        let exp = expectation(description: "Loading film resource")
        let handler: FetchHandler = { error in
            guard let _ = error else {
                exp.fulfill()
                return
            }
        }
        let viewModel = MasterViewModel(filterHandler: {})
        viewModel.fetchFilmResource(handler: handler)
        waitForExpectations(timeout: 2)
    }
    
    func testFilterHndler() {
        let exp = expectation(description: "Loading filter")
        let viewModel = MasterViewModel(filterHandler: { exp.fulfill() })
        viewModel.searchTerm = "test"
        waitForExpectations(timeout: 1)
    }
    
    func testFetch() {
        let expFetch = expectation(description: "Fetching")
        let viewModel = MasterViewModel { }
        viewModel.fetchFilmResource { error in
            expFetch.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(viewModel.film)
    }

    func testFilterMultipleResults() {
        let expFilter = expectation(description: "Filtering")
        let viewModel = MasterViewModel { expFilter.fulfill() }
        viewModel.fetchFilmResource { _ in
            viewModel.searchTerm = "li"
        }
        waitForExpectations(timeout: 1)
        XCTAssertEqual(viewModel.filteredCast.count, 5)
    }

    func testFilterMultipleUppercaseResults() {
        let expFilter = expectation(description: "Filtering")
        let viewModel = MasterViewModel { expFilter.fulfill() }
        viewModel.fetchFilmResource { _ in
            viewModel.searchTerm = "LI"
        }
        waitForExpectations(timeout: 1)
        XCTAssertEqual(viewModel.filteredCast.count, 5)
    }

    func testFilterUniqueResult() {
        let expFilter = expectation(description: "Filtering")
        let viewModel = MasterViewModel { expFilter.fulfill() }
        viewModel.fetchFilmResource { _ in
            viewModel.searchTerm = "Lis"
        }
        waitForExpectations(timeout: 1)
        XCTAssertEqual(viewModel.filteredCast.count, 1)
    }

    func testFilterUniqueUppercaseResult() {
        let expFilter = expectation(description: "Filtering")
        let viewModel = MasterViewModel { expFilter.fulfill() }
        viewModel.fetchFilmResource { _ in
            viewModel.searchTerm = "LIS"
        }
        waitForExpectations(timeout: 1)
        XCTAssertEqual(viewModel.filteredCast.count, 1)
    }
}
