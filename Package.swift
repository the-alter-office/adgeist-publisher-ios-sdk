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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.25-beta.2/AdgeistKit.xcframework.zip",
            checksum: "cc96d65b75d03b01d2f0539bdfa454928e7450685967ca09e2d9308e4b517733"
        )
    ]
)
