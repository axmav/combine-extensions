//
//  GraphRequest+Extensions.swift
//  insta
//
//  Created by Alexandr Mavrichev on 04.06.22.
//

import Foundation
import Combine
import FacebookCore

struct GraphRequestUnwrappingException: Error {
}

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
        }
        .eraseToAnyPublisher()
    }
    
    func start<T>(type: T.Type) -> AnyPublisher<T, Error> {
        start()
            .tryMap({ result -> T in
                if let res = result as? T {
                    return res
                }
                throw GraphRequestUnwrappingException()
            })
            .eraseToAnyPublisher()
    }
}

