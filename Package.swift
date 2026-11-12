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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.26-beta.4/AdgeistKit.xcframework.zip",
            checksum: "d71d42ad4c6d0be01fcb7ab3d8a5def30bbffb126954312700945ffdc69cc1a7"
        )
    ]
)
