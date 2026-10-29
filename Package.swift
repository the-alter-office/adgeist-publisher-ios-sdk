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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.25-beta.3/AdgeistKit.xcframework.zip",
            checksum: "4bb8a5b882d812c57f390d3fa34e5146102df6c97f18b038556d960dbaff239c"
        )
    ]
)
