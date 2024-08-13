//
//  MockLoanDetailsViewModel.swift
//  LoanDetailsProject
//
//  Created by Claudio Vega on 12-08-24.
//

import Combine

class MockLoanDetailsViewModel: LoanDetailsViewModel {
    override init(service: LoanDetailsServiceProtocol = MockLoanDetailsService()) {
        super.init(service: service)
        self.loanDetails = MockData.loanDetails
    }
}

class MockLoanDetailsService: LoanDetailsServiceProtocol {
    func fetchLoanDetails() -> AnyPublisher<LoanDetails, Error> {
        Just(MockData.loanDetails)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

