//
//  LoanDetailsViewModel.swift
//  LoanDetailsProject
//
//  Created by Claudio Vega on 12-08-24.
//

import Combine
import Foundation

class LoanDetailsViewModel: ObservableObject {
    @Published var loanDetails: LoanDetails?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let service: LoanDetailsServiceProtocol
    
    init(service: LoanDetailsServiceProtocol = LoanDetailsService()) {
        self.service = service
        fetchLoanDetails()
    }
    
    func fetchLoanDetails() {
        service.fetchLoanDetails()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { loanDetails in
                self.loanDetails = loanDetails
            })
            .store(in: &cancellables)
    }
}
