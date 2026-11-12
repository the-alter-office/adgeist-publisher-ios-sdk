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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.26-beta.3/AdgeistKit.xcframework.zip",
            checksum: "89d5fa6791e62e01902b09011893e5fff0f69a7e1366b0ae51520e4c63e5cc6f"
        )
    ]
)
