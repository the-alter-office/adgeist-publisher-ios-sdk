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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.21/AdgeistKit.xcframework.zip",
            checksum: "e7a97d8aa78dcb8bb23fecb91911d8f779cfaad366575dc604a436659a02f0ac"
        )
    ]
)
