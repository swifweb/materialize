// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "materialize",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Materialize", type: .static, targets: ["Materialize"])
    ],
    dependencies: [
        .package(url: "https://github.com/swifweb/web", from: "1.0.0")
    ],
    targets: [
        .target(name: "Materialize", dependencies: [
            .product(name: "Web", package: "web")
        ], resources: [
            .copy("css/materialize.min.css"),
            .copy("css"),
            .copy("js/materialize.min.js"),
            .copy("js/materialize.js"),
            .copy("js")
        ]),
        .testTarget(name: "MaterializeTests", dependencies: ["Materialize"])
    ]
)
