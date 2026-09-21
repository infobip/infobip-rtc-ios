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
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.13/InfobipRTC.zip",
            checksum: "10c187304d8c95241a437e8c1b425c79bfcbe4f35e83a67f5d0c8a2fa7e70f4d"
        ),
        .binaryTarget(
            name: "InfobipRTCBroadcastExtension",
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.13/InfobipRTCBroadcastExtension.zip",
            checksum: "99ea86c3b83058267f492e6d9c057d656cf2bf8d885512487495bcda01c4cfed"
        ),
        .binaryTarget(
            name: "IBWebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.47486/IBWebRTC.zip",
            checksum: "5cb5d71e0e89be2aa85410792fb422d7f432965c478bf80eefe94b166d1e97a2"
        )
    ]
)

