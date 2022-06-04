# Apple Combine Extensions

## Facebook SDK GraphRequest

Facebook SDK GraphRequest Swift Combine support ([GraphRequest+Extensions.swift](https://github.com/axmav/combine-extensions/blob/main/GraphRequest%2BExtensions.swift)) with decoder support.

```swift
struct Account: Codable, Equatable {
    let id: String
    let name: String
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
      case id
      case name
      case firstName = "first_name"
    }
}
```
```swift
let publisher = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"])
                .start(type: Account.self)
```

## Facebook Login

Facebook SDK Login button for SwiftUI + Combine ([LoginManager+Extensions.swift](https://github.com/axmav/combine-extensions/blob/main/LoginManager%2BExtensions.swift)). In the example below we use it in combination with GraphRequest.

```swift
LoginManager()
            .logIn(permissions: [.publicProfile, .email])
            .flatMap { loginResult -> AnyPublisher<Account?, Error> in
                switch loginResult {
                case .failed(let error):
                    return Fail(outputType: Account?.self, failure: error).eraseToAnyPublisher()
                case .cancelled:
                    return Just(Account?.none)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    return GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"])
                        .start(type: Account.self)
                }
            }
```
