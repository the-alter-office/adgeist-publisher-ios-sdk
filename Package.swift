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
            url: "https://github.com/the-alter-office/adgeist-publisher-ios-sdk/releases/download/1.0.26-beta.11/AdgeistKit.xcframework.zip",
            checksum: "dce78701097c87652fc6ddf25cf95d2a598679a131b7f5b4fac21367bdd86788"
        )
    ]
)
