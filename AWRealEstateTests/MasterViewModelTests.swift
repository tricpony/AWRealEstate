//
//  MasterViewModelTests.swift
//  AWRealEstateTests
//
//  Created by aarthur on 4/29/23.
//

import XCTest
@testable import AWRealEstate

final class MasterViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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

    func testUnSuccessfulFetch() {
        let exp = expectation(description: "Loading film resource")
        let handler: FetchHandler = { error in
            guard let _ = error else {
                XCTFail("unexpected service success")
                return
            }
            exp.fulfill()
        }
        guard let bogusURL = URL(string: "http://the-internet.herokuapp.com/status_codes/301") else {
            XCTFail()
            return
        }
        let viewModel = MasterViewModel(filterHandler: {}, serviceAddress: bogusURL)
        viewModel.fetchFilmResource(handler: handler)
        waitForExpectations(timeout: 2)
    }
}
