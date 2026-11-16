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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.26-beta.8/AdgeistKit.xcframework.zip",
            checksum: "f955a3289bc27f343f99dab3b39e5199c44054eaebc083d9eaa199995ad4262b"
        )
    ]
)
