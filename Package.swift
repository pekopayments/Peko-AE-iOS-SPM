// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Peko-AE-iOS",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Peko-AE-iOS",
            targets: ["Peko-AE-iOS", "PekoSDK"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/PureLayout/PureLayout.git", .upToNextMajor(from: "3.1.9")),
        .package(url: "https://github.com/WenchaoD/FSCalendar.git", .upToNextMajor(from: "2.8.4")),
        .package(url: "https://github.com/Juanpe/SkeletonView.git", .upToNextMajor(from: "1.7.0")),
        .package(url: "https://github.com/alickbass/CodableFirebase", .upToNextMajor(from: "0.2.2")),
//        .package(url: "https://github.com/iziz/libPhoneNumber-iOS", .upToNextMajor(from: "1.2.0")),
            .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.4")),
            .package(url: "https://github.com/SDWebImage/SDWebImage.git", .upToNextMajor(from: "5.21.2")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Peko-AE-iOS",
            dependencies: [
                .product(name: "PureLayout", package: "PureLayout"),
                .product(name: "FSCalendar", package: "FSCalendar"),
                .product(name: "SkeletonView", package: "SkeletonView"),
                .product(name: "CodableFirebase", package: "CodableFirebase"),
//                .product(name: "libPhoneNumber", package: "libPhoneNumber-iOS"),
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "SDWebImage", package: "SDWebImage"),
            ],
//            resources: [
//                .process("Fonts")   // <-- Include font files
//            ]
        ),
        .binaryTarget(name: "PekoSDK", path: "./PekoSDK.xcframework")
    ]
)

