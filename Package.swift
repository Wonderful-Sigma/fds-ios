// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FDS",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "FDS",
            targets: ["FDS"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dagronf/qrcode.git", from: "16.1.1")
    ],
    targets: [
        .target(
            name: "FDS",
            dependencies: [.product(name: "QRCode", package: "qrcode")])
    ]
)
