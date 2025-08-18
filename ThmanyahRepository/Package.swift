// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ThmanyahRepository",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ThmanyahRepository",
            targets: ["ThmanyahRepository"]),
    ],
    dependencies: [
        .package(path: "../ThmanyahNetworkLayer"),
        .package(path: "../ThmanyahCoreAPI"),
        .package(path: "../ThmanyahUseCase")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ThmanyahRepository",
            dependencies: [
                .product(name: "ThmanyahNetworkLayer", package: "ThmanyahNetworkLayer"),
                .product(name: "ThmanyahCoreAPI", package: "ThmanyahCoreAPI"),
                .product(name: "ThmanyahUseCase", package: "ThmanyahUseCase")
            ]
        ),
        .testTarget(
            name: "ThmanyahRepositoryTests",
            dependencies: ["ThmanyahRepository"]
        ),
    ]
)
