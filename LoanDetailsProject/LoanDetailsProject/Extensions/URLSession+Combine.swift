//
//  URLSession+Combine.swift
//  LoanDetailsProject
//
//  Created by Claudio Vega on 12-08-24.
//

import Combine
import Foundation

extension URLSession {
    func dataTaskPublisher(for url: URL) -> AnyPublisher<Data, URLError> {
        self.dataTaskPublisher(for: URLRequest(url: url))
            .map(\.data)
            .eraseToAnyPublisher()
    }
}

