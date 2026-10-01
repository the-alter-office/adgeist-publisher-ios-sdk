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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.23/AdgeistKit.xcframework.zip",
            checksum: "8328915005ece424cc2ccf1c727c95708fd2ef1d4ab1fa800e95baf9d3213de6"
        )
    ]
)
