//
//  GraphRequest+Extensions.swift
//  insta
//
//  Created by Alexandr Mavrichev on 04.06.22.
//

import Foundation
import Combine
import FacebookCore

extension GraphRequest {
    func start() -> AnyPublisher<Any?, Error> {
        return Deferred {
            Future<Any?, Error> { promise in
                self.start { _, result, error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(result))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}

