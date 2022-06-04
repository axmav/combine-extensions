# Apple Combine Extensions

## Facebook SDK GraphRequest

Facebook SDK GraphRequest swift combine support ([GraphRequest+Extensions.swift](https://github.com/axmav/combine-extensions/blob/main/GraphRequest%2BExtensions.swift)) with decoder support.

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
