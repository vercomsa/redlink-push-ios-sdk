// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Redlink",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Redlink",
            targets: ["RedlinkSPMTarget"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RedlinkSPMTarget",
            dependencies: [
                "RedlinkSPMWrapper"
            ],
            path: "SwiftPM-PlatformExclude/RedlinkSPMTarget"
        ),
        .target(
            name: "RedlinkSPMWrapper",
            dependencies: [
                "Redlink"
            ],
            path: "RedlinkSPMWrapper"
        ),
        .binaryTarget(
            name: "Redlink",
            path: "Framework/SPM/Redlink.xcframework"
        )
    ]
)
