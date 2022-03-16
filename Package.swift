// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "GeometryWriter",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "GeometryWriter",
            targets: ["GeometryWriter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/heestand-xyz/PixelKit", .exactItem("3.0.3")),
        .package(url: "https://github.com/heestand-xyz/MultiViews", .exactItem("1.5.6")),
    ],
    targets: [
        .target(
            name: "GeometryWriter",
            dependencies: ["PixelKit", "MultiViews"]),
    ]
)
