// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "OhhAuth",
    products: [
        .library(name: "OhhAuth", targets: ["OhhAuth"])
    ],
    targets: [
        .target(name: "OhhAuth", path: ".")
    ]
)
