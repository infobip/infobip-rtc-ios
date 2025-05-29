// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "InfobipRTC",
    products: [
        .library(
            name: "InfobipRTC",
            targets: ["InfobipRTC"]
        ),
        .library(
            name: "WebRTC",
            targets: ["WebRTC"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "InfobipRTC",
            url: "https://rtc.cdn.infobip.com/ios/2/2.5.8/InfobipRTC.zip",
            checksum: "9cfd7cdb88a3c88a484c8133310d9526cae9cd9bfdd010397679fdc26e439102"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.42802/WebRTC.zip",
            checksum: "2b7d4f33d7d1ff840f8f4d835a776dbe1844598dae62dbc2bd94c9cacabf5cd5"
        )
    ]
)

