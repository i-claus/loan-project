//
//  LoanDetailsService.swift
//  LoanDetailsProject
//
//  Created by Claudio Vega on 12-08-24.
//

import Combine
import Foundation

protocol LoanDetailsServiceProtocol {
    func fetchLoanDetails() -> AnyPublisher<LoanDetails, Error>
}

class LoanDetailsService: LoanDetailsServiceProtocol {
    func fetchLoanDetails() -> AnyPublisher<LoanDetails, Error> {
        let jsonString = """
        {
            "email": "example@example.com",
            "paymentDetails": {
                "dueInDays": 2,
                "amountDue": 325.93,
                "nextPaymentDate": "2024-02-24",
                "paymentProgress": {
                    "currentPaymentNumber": 8,
                    "totalPayments": 10
                }
            },
            "loanDetails": {
                "loanID": "JMI-923429",
                "remainingBalance": 652,
                "amountBorrowed": 3250,
                "interestPaidToDate": 319.77,
                "interestRate": 9.9,
                "maxCreditAmount": 10000,
                "repaymentDay": 12,
                "lastFourPaymentCard": "7284",
                "numberOfDocuments": 4
            }
        }
        """
        let data = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        
        return Just(data)
            .decode(type: LoanDetails.self, decoder: decoder)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

