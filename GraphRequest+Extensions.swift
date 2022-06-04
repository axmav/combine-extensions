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
        }
        .eraseToAnyPublisher()
    }
    
    func start<T>(type: T.Type, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T?, Error> where T: Decodable {
        start()
            .tryMap({ result -> T? in
                guard let result = result else { return nil }
                let object = try decoder.decode(T.self, from: JSONSerialization.data(withJSONObject: result))
                return object
            })
            .eraseToAnyPublisher()
    }
}

