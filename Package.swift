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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.22/AdgeistKit.xcframework.zip",
            checksum: "bef8ec89a969f932d0e67e45fede83ac4b130a839da7161c6ea00950a407d374"
        )
    ]
)
