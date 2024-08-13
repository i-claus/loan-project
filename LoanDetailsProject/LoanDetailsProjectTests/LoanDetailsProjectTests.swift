//
//  LoanDetailsProjectTests.swift
//  LoanDetailsProjectTests
//
//  Created by Claudio Vega on 12-08-24.
//

import XCTest
import Combine
@testable import LoanDetailsProject

class LoanDetailsServiceTests: XCTestCase {

    var service: LoanDetailsService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        service = LoanDetailsService()
        cancellables = []
    }

    override func tearDown() {
        service = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchLoanDetailsSuccess() {
        // Given
        let expectation = self.expectation(description: "LoanDetails fetched successfully")

        // When
        var loanDetails: LoanDetails?
        var fetchError: Error?

        service.fetchLoanDetails()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    fetchError = error
                }
            }, receiveValue: { details in
                loanDetails = details
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(loanDetails)
        XCTAssertNil(fetchError)
        XCTAssertEqual(loanDetails?.email, "example@example.com")
        XCTAssertEqual(loanDetails?.paymentDetails.amountDue, 325.93)
        XCTAssertEqual(loanDetails?.loanDetails.loanID, "JMI-923429")
    }

    func testFetchLoanDetailsFailure() {
        // Given
        class FailingLoanDetailsService: LoanDetailsService {
            override func fetchLoanDetails() -> AnyPublisher<LoanDetails, Error> {
                return Fail(error: URLError(.badServerResponse))
                    .eraseToAnyPublisher()
            }
        }

        let failingService = FailingLoanDetailsService()
        let expectation = self.expectation(description: "LoanDetails fetch failed")

        // When
        var loanDetails: LoanDetails?
        var fetchError: Error?

        failingService.fetchLoanDetails()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    fetchError = error
                    expectation.fulfill()
                }
            }, receiveValue: { details in
                loanDetails = details
            })
            .store(in: &cancellables)

        // Then
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNil(loanDetails)
        XCTAssertNotNil(fetchError)
    }
}

