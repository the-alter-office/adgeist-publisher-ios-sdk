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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.25-beta.1/AdgeistKit.xcframework.zip",
            checksum: "c03e1907eeace47619c22976c4ceeb7e5c96df751ae10839b6026eaa4261d060"
        )
    ]
)
