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
            targets: ["Peko-AE-iOS"]
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
//        .package(url: "https://github.com/pusher/pusher-websocket-swift", .upToNextMajor(from: "10.1.6")),
      
        
        
         //   .package(url: "https://github.com/makwanahardik82/Peko-AE-iOS-Utility-SPM.git", .upToNextMajor(from: "1.0.0")),
            
          //  .package(path: "../Peko-AE-iOS-Utility")
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
//                .product(name: "PusherSwift", package: "pusher-websocket-swift"),
                //    .product(name: "Peko-AE-iOS-Utility", package: "Peko-AE-iOS-Utility-SPM")
                
                 //   .product(name: "Peko-AE-iOS-Utility", package: "Peko-AE-iOS-Utility")
            ],
            resources: [
                .process("Fonts")   // <-- Include font files
            ]
        ),

    ]
)


/*

let package = Package(
    name: "Peko-AE-iOS",
    platforms: [.iOS(.v14)],
    products: [
        // Only expose the main target to consumers
        .library(
            name: "Peko-AE-iOS",
            targets: ["Peko-AE-iOS"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Juanpe/SkeletonView.git", .upToNextMajor(from: "1.7.0")),
        .package(url: "https://github.com/alickbass/CodableFirebase", .upToNextMajor(from: "0.2.2")),
        .package(url: "https://github.com/makwanahardik82/Peko-AE-iOS-Utility-SPM.git", .upToNextMajor(from: "1.0.0")),
        
        
            //.package(path: "../Peko-AE-iOS-Utility")
    ],
    targets: [
        
        // MARK: - Main Public Target
        .target(
            name: "Peko-AE-iOS",
            dependencies: [
                "PekoDashboard",   // include the hidden target internally
//                .product(name: "PureLayout", package: "PureLayout"),
//                .product(name: "FSCalendar", package: "FSCalendar"),
                .product(name: "SkeletonView", package: "SkeletonView"),
                .product(name: "CodableFirebase", package: "CodableFirebase"),
                .product(name: "Peko-AE-iOS-Utility", package: "Peko-AE-iOS-Utility-SPM")
            ],
//            path: "Sources/Peko-AE-iOS",
//            exclude: ["Dashboard"] // avoid duplicate compilation
        ),

//        // MARK: - Internal Hidden Dashboard Target
//        .target(
//            name: "PekoDashboard",
//            dependencies: [
//                .product(name: "Peko-AE-iOS-Utility", package: "Peko-AE-iOS-Utility-SPM")
//            ],
//            path: "Sources/Peko-AE-iOS/Dashboard"
//        )
    ]
)

let package = Package(
    name: "Peko-AE-iOS",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Peko-AE-iOS",
            targets: ["Peko-AE-iOS"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/PureLayout/PureLayout.git", .upToNextMajor(from: "3.1.9")),
        .package(url: "https://github.com/WenchaoD/FSCalendar.git", .upToNextMajor(from: "2.8.4")),
        .package(url: "https://github.com/Juanpe/SkeletonView.git", .upToNextMajor(from: "1.7.0")),
        .package(url: "https://github.com/alickbass/CodableFirebase", .upToNextMajor(from: "0.2.2")),
        .package(url: "https://github.com/makwanahardik82/Peko-AE-iOS-Utility-SPM.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        
        // Public target — exposed to consumers
        .target(
            name: "Peko-AE-iOS",
            dependencies: [
                "PekoDashboard", // internal hidden module
                .product(name: "PureLayout", package: "PureLayout"),
                .product(name: "FSCalendar", package: "FSCalendar"),
                .product(name: "SkeletonView", package: "SkeletonView"),
                .product(name: "CodableFirebase", package: "CodableFirebase"),
                .product(name: "Peko-AE-iOS-Utility", package: "Peko-AE-iOS-Utility-SPM")
            ],
            path: "Sources/Peko-AE-iOS"
        ),

        // Internal-only Dashboard target (now outside Sources/)
        .target(
            name: "PekoDashboard",
            dependencies: [
                .product(name: "Peko-AE-iOS-Utility", package: "Peko-AE-iOS-Utility-SPM")
            ],
            path: "PrivateModules/Dashboard",
        )
    ]
)
*/
