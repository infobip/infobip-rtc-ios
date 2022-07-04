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
            url: "https://rtc.cdn.infobip.com/ios/1.4.60/InfobipRTC.zip",
            checksum: "4e6c4eb57d70aabc58b93b864958fff1a28a56da1ba0a8f6855eb63d2c6b0809"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.36614/WebRTC.zip",
            checksum: "7e0f7f210db34d31f3f1984255fae5387e8e966d5d1b0e707ca0a7d11098e7d7"
        )
    ]
)

