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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.24-beta.2/AdgeistKit.xcframework.zip",
            checksum: "ff1850115ce44df9a80a27d14422d2e5c97727d7cf576272739ad00cb20bea15"
        )
    ]
)
