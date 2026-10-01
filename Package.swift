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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.24-beta.1/AdgeistKit.xcframework.zip",
            checksum: "4e3cbd18fc4146eda7759a5ab35b8c2475e744df2681aae4831c7f6c421ce4e1"
        )
    ]
)
