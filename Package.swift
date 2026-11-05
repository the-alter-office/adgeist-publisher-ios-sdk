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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.26-beta.1/AdgeistKit.xcframework.zip",
            checksum: "274a1cdf0d66f515c89290e14bc49ea748ec700743ffa1609697418af1ecf9d0"
        )
    ]
)
