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
            url: "https://rtc.cdn.infobip.com/ios/2/2.5.7/InfobipRTC.zip",
            checksum: "d1e7bedc5751465f47c3e71e14658230d15052c52226cd93405330f894319476"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.42802/WebRTC.zip",
            checksum: "2b7d4f33d7d1ff840f8f4d835a776dbe1844598dae62dbc2bd94c9cacabf5cd5"
        )
    ]
)

