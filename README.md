# OhhAuth
### Pure Swift implementation of the OAuth 1.0 protocol as an easy to use extension for the URLRequest type. [(RFC-5849)](https://tools.ietf.org/html/rfc5849])

Even though its successor is already specified, the OAuth 1.0 protocol is still in wide use. This easy to use extension for the `URLRequest` type implements the most common OAuth client side request variants.


#### Requirements
OhhAuth depends on `libCommonCrypto` which is already installed on all common Apple operating systems (macOS, iOS, tvOS, watchOS). Unfortunately Linux is not support at the moment, but is likely to be added in the near future.


## Usage example

#### The classic usage example would be posting a tweet on Twitter:

To get the consumer credentials (key and secret) you first have to register a new Twitter app at https://apps.twitter.com

There are a lot of ways to get the user credentials (like oauth reverse authentication) but for testing the by far easiest method would be directly from your [twitter app page](https://apps.twitter.com) by using [this guide](https://dev.twitter.com/oauth/overview/application-owner-access-tokens).

Also for further information about `api.twitter.com/1.1/statuses/update.json` please refer to the [Twitter API documentation](https://dev.twitter.com/rest/reference/post/statuses/update).


```swift
let cc = (key: "<YOUR APP CONSUMER KEY>", secret: "<YOUT APP CONSUMER SECRET>")
let uc = (key: "<YOUR USER KEY>", secret: "<YOUR USER SECRET>")

var req = URLRequest(url: URL(string: "https://api.twitter.com/1.1/statuses/update.json")!)

let paras = ["status": "Hey Twitter! \u{1F6A7} Take a look at this sweet UUID: \(UUID())"]

req.oAuthSign(method: "POST", urlFormParameters: paras, consumerCredentials: cc, userCredentials: uc)

let task = URLSession(configuration: .ephemeral).dataTask(with: req) { (data, response, error) in
    
    if let error = error {
        print(error)
    }
    else if let data = data {
        print(String(data: data, encoding: .utf8) ?? "Does not look like a utf8 response :(")
    }
}
task.resume()
```

## Install

#### Cocoa Pods

To integrate OhhAuth into your Xcode project using CocoaPods, add it to your `Podfile`:

```ruby
target '<your_target_name>' do
    pod 'OhhAuth'
end
```

Then, run the following command:

```bash
$ pod install
```

You then will need to add `import OhhAuth` at the top of your swift source files to use the extension.


#### Swift Package Manager

To integrate OhhAuth into your Xcode project using the swift package manager, add it as a dependency to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "<your_package_name>",
    dependencies: [
        .Package(url: "https://github.com/mw99/OhhAuth.git", majorVersion: 1)
    ]
)
```

You then will need to add `import OhhAuth` at the top of your swift source files to use the extension.


#### Or just copy the file into your project

You only need one file located at `Sources/OhhAuth.swift`. Just drag and drop it into the Xcode project navigator.



## Interface

##### As `URLRequest` extension:
```swift
/// Easy to use method to sign a URLRequest which includes url-form parameters with OAuth.
/// The request needs a valid URL with all query parameters etc. included.
/// After calling this method the HTTP header fields: "Authorization", "Content-Type" 
/// and "Content-Length" should not be overwritten.
///
/// - Parameters:
///   - method: HTTP Method
///   - paras: url-form parameters
///   - consumerCredentials: consumer credentials
///   - userCredentials: user credentials (nil if this is a request without user association)
public mutating func oAuthSign(method: String, urlFormParameters paras: [String: String],
    consumerCredentials cc: OhhAuth.Credentials, userCredentials uc: OhhAuth.Credentials? = nil)
```

```swift
/// Easy to use method to sign a URLRequest which includes plain body data with OAuth.
/// The request needs a valid URL with all query parameters etc. included.
/// After calling this method the HTTP header fields: "Authorization", "Content-Type"
/// and "Content-Length" should not be overwritten.
///
/// - Parameters:
///   - method: HTTP Method
///   - body: HTTP request body (default: nil)
///   - contentType: HTTP header "Content-Type" entry (default: nil)
///   - consumerCredentials: consumer credentials
///   - userCredentials: user credentials (nil if this is a request without user association)
public mutating func oAuthSign(method: String, body: Data? = nil, contentType: String? = nil,
    consumerCredentials cc: OhhAuth.Credentials, userCredentials uc: OhhAuth.Credentials? = nil)
```

##### Direct access from `class OhhAuth`


```swift
/// Function to calculate the OAuth protocol parameters and signature ready to be added
/// as the HTTP header "Authorization" entry. A detailed explanation of the procedure 
/// can be found at: [RFC-5849 Section 3](https://tools.ietf.org/html/rfc5849#section-3)
///
/// - Parameters:
///   - url: Request url (with all query parameters etc.)
///   - method: HTTP method
///   - parameter: url-form parameters
///   - consumerCredentials: consumer credentials
///   - userCredentials: user credentials (nil if this is a request without user association)
///
/// - Returns: OAuth HTTP header entry for the Authorization field.
open static func calculateSignature(url: URL, method: String, parameter: [String: String],
    consumerCredentials cc: Credentials, userCredentials uc: Credentials?) -> String
```

```swift    
/// Function to perform the right percentage encoding for url form parameters.
///
/// - Parameter paras: url-form parameters
/// - Parameter encoding: used string encoding (default: .utf8)
/// - Returns: correctly percentage encoded url-form parameters
open static func httpBody(forFormParameters paras: [String: String], 
    encoding: String.Encoding = .utf8) -> Data?
```

