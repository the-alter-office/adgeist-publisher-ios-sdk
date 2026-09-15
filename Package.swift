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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.18/AdgeistKit.xcframework.zip",
            checksum: "417091ecf9ce00bf75b74483b59ee2eb5f3c17266de6c6ca5b8e5145a699732b"
        )
    ]
)
