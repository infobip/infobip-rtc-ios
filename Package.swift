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
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.14/InfobipRTC.zip",
            checksum: "abea288545e1153719b5f0bb1c2f1cbcf666d76d44380c0fa7781766aa61b9f5"
        ),
        .binaryTarget(
            name: "InfobipRTCBroadcastExtension",
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.14/InfobipRTCBroadcastExtension.zip",
            checksum: "187c6dd2660604ebb114578dd0b9d563333859a4c80f0c4ecc661b80145eb73c"
        ),
        .binaryTarget(
            name: "IBWebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.47486/IBWebRTC.zip",
            checksum: "5cb5d71e0e89be2aa85410792fb422d7f432965c478bf80eefe94b166d1e97a2"
        )
    ]
)

