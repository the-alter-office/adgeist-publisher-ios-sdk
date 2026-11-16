// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "AdgeistKit",
    platforms: [
        .iOS("15.6")
    ],
    products: [
        .library(
            name: "AdgeistKit",
            targets: ["AdgeistKit"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "AdgeistKit",
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.26-beta.9/AdgeistKit.xcframework.zip",
            checksum: "3d4455b613df11ed33585927dfce18cd0f4a6d99bb471968d2d52bdb013f9ecd"
        )
    ]
)
