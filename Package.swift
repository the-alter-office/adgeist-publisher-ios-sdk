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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.24/AdgeistKit.xcframework.zip",
            checksum: "724b5600101319c2078c8c0ba722bb707a5efe2e1d247bda46fc7f6c26839f0c"
        )
    ]
)
