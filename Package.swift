// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHCoordinator",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "SHCoordinator",
            targets: ["SHCoordinator"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SHCoordinator",
            dependencies: []),
        .testTarget(
            name: "SHCoordinatorTests",
            dependencies: ["SHCoordinator"]),
    ],
    swiftLanguageVersions: [.v5]
)
