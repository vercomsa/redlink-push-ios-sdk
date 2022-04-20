// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Redlink",
    products: [
        .library(
            name: "Redlink",
            targets: ["RedlinkSPMTarget"]
        ),
    ],
    dependencies: [
        .package(name: "SQLite.swift", url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.13.3")
    ],
    targets: [
        .target(
            name: "RedlinkSPMTarget",
            dependencies: [
                .target(name: "RedlinkSPMWrapper", condition: .when(platforms: [.iOS])),
            ],
            path: "SwiftPM-PlatformExclude/RedlinkSPMTarget"
        ),
        .target(
            name: "RedlinkSPMWrapper",
            dependencies: [
                .target(name: "Redlink", condition: .when(platforms: [.iOS])),
                .product(name: "SQLite", package: "SQLite.swift")
            ],
            path: "RedlinkSPMWrapper"
        ),
        .binaryTarget(
            name: "Redlink",
            path: "Framework/Redlink.xcframework"
        ),
    ]
)
