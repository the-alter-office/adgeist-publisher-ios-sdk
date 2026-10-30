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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.25/AdgeistKit.xcframework.zip",
            checksum: "d655e68febe1506d4ab6290336c96258123f2bdeca103ae76dd533cd0c1d83a7"
        )
    ]
)
