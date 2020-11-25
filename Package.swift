// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "TealiumCrashReporter",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "CrashReporter", targets: ["CrashReporter"])
    ],
    targets: [
        .binaryTarget(name: "CrashReporter", path: "./CrashReporter.xcframework") 
    ]
)
