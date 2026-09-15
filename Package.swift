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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.19/AdgeistKit.xcframework.zip",
            checksum: "5b16e28b880c69ca3682ada71e0f71d1b663180e250193dd3d91eb95b7aaa94c"
        )
    ]
)
