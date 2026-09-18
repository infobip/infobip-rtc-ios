// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "InfobipRTC",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "InfobipRTC",
            targets: ["InfobipRTC"]
        ),
        .library(
            name: "InfobipRTCBroadcastExtension",
            targets: ["InfobipRTCBroadcastExtension"]
        ),
        .library(
            name: "IBWebRTC",
            targets: ["IBWebRTC"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "InfobipRTC",
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.12/InfobipRTC.zip",
            checksum: "2daad0cc2dbbf4a50fc74b381a5c911c8b685da626a3d592e1100eb99f392587"
        ),
        .binaryTarget(
            name: "InfobipRTCBroadcastExtension",
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.12/InfobipRTCBroadcastExtension.zip",
            checksum: "81e75cf37baf7081f484729c649c0e346431267bff4dfc847c3dcf94fe2dd993"
        ),
        .binaryTarget(
            name: "IBWebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.47486/IBWebRTC.zip",
            checksum: "5cb5d71e0e89be2aa85410792fb422d7f432965c478bf80eefe94b166d1e97a2"
        )
    ]
)

