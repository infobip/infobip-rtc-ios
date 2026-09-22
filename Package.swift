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
            checksum: "daac18a545bebbe5d9179e764b57f11927fe3bfc8ee0641a5a1ef38b901c5fd6"
        ),
        .binaryTarget(
            name: "InfobipRTCBroadcastExtension",
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.13/InfobipRTCBroadcastExtension.zip",
            checksum: "44be0e873c92a2d187124f3fc5b6f8babfd57419f49c14c13336b6dd317263b4"
        ),
        .binaryTarget(
            name: "IBWebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.47486/IBWebRTC.zip",
            checksum: "5cb5d71e0e89be2aa85410792fb422d7f432965c478bf80eefe94b166d1e97a2"
        )
    ]
)

