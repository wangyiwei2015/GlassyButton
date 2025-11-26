// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "GlassyButton",
    platforms: [.iOS(.v15)],
    products: [.library(
        name: "GlassyButton",
        targets: ["GlassyButton"]
    ),],
    targets: [.target(name: "GlassyButton")]
)
