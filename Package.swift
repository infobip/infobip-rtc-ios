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
            url: "https://rtc.cdn.infobip.com/ios/2/2.5.6/InfobipRTC.zip",
            checksum: "1d06dce209ce2529bf152cd6d3edb8c6ac0cd4b993157a58036d360626129166"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.42802/WebRTC.zip",
            checksum: "2b7d4f33d7d1ff840f8f4d835a776dbe1844598dae62dbc2bd94c9cacabf5cd5"
        )
    ]
)

