//
//  LoanDetailsModel.swift
//  LoanDetailsProject
//
//  Created by Claudio Vega on 12-08-24.
//

import Foundation

struct LoanDetails: Codable {
    let email: String
    let paymentDetails: PaymentDetails
    let loanDetails: LoanDetail
    
    struct PaymentDetails: Codable {
        let dueInDays: Int
        let amountDue: Double
        let nextPaymentDate: String
        let paymentProgress: PaymentProgress
       
        struct PaymentProgress: Codable {
           let currentPaymentNumber: Int
           let totalPayments: Int
        }
    }
    
    struct LoanDetail: Codable {
        let loanID: String
        let remainingBalance: Double
        let amountBorrowed: Double
        let interestPaidToDate: Double
        let interestRate: Double
        let maxCreditAmount: Double
        let repaymentDay: Int
        let lastFourPaymentCard: String
        let numberOfDocuments: Int
    }
}

struct MockData {
    static let loanDetails = LoanDetails(
        email: "hola@softgic.com",
        paymentDetails: LoanDetails.PaymentDetails(
            dueInDays: 2,
            amountDue: 325.93,
            nextPaymentDate: "2024-02-24",
            paymentProgress: LoanDetails.PaymentDetails.PaymentProgress(
                currentPaymentNumber: 8,
                totalPayments: 10
            )
        ),
        loanDetails: LoanDetails.LoanDetail(
            loanID: "JMI-923429",
            remainingBalance: 652,
            amountBorrowed: 3250,
            interestPaidToDate: 319.77,
            interestRate: 9.9,
            maxCreditAmount: 10000,
            repaymentDay: 12,
            lastFourPaymentCard: "7284",
            numberOfDocuments: 4
        )
    )
}
