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
            url: "https://rtc.cdn.infobip.com/ios/2/2.5.9/InfobipRTC.zip",
            checksum: "83b84653738521e25724f7d64dcdec437a69fe88f4d468bc03fb3cd8c045a535"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.42802/WebRTC.zip",
            checksum: "2b7d4f33d7d1ff840f8f4d835a776dbe1844598dae62dbc2bd94c9cacabf5cd5"
        )
    ]
)

