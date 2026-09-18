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
            checksum: "8b89a6473492c51f2a977939dbc018cf3fb819ff068f013c85b637210c103b18"
        ),
        .binaryTarget(
            name: "InfobipRTCBroadcastExtension",
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.12/InfobipRTCBroadcastExtension.zip",
            checksum: "b231e1706377c8c08d888fdc5dd657a98597c282b6b66550a4cb06426a0b7352"
        ),
        .binaryTarget(
            name: "IBWebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.47486/IBWebRTC.zip",
            checksum: "5cb5d71e0e89be2aa85410792fb422d7f432965c478bf80eefe94b166d1e97a2"
        )
    ]
)

