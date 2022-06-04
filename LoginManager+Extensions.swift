//
//  LoginManager+Extensions.swift
//  insta
//
//  Created by Alexandr Mavrichev on 04.06.22.
//

import Foundation
import Combine
import FacebookLogin

extension LoginManager {
    func logIn(permissions: [FBSDKCoreKit.Permission]) -> AnyPublisher<FBSDKLoginKit.LoginResult, Error> {
        return Deferred {
            Future<FBSDKLoginKit.LoginResult, Error> { promise in
                self.logIn(permissions: permissions, viewController: nil) { res in
                    promise(.success(res))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

