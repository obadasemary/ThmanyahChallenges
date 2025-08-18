// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ThmanyahUseCase",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ThmanyahUseCase",
            targets: ["ThmanyahUseCase"]),
    ],
    dependencies: [
        .package(path: "../DependencyContainer")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ThmanyahUseCase",
            dependencies: [
                .product(name: "DependencyContainer", package: "DependencyContainer")
            ]
        ),
        .testTarget(
            name: "ThmanyahUseCaseTests",
            dependencies: ["ThmanyahUseCase"]
        ),
    ]
)
