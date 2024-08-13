//
//  NetworkManager.swift
//  LoanDetailsProject
//
//  Created by Claudio Vega on 12-08-24.
//

import Combine
import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

