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
            checksum: "41f2f95a23b2207ebd00fb1b7d4a4fdd983dbd4ab351478ad97cd6a633f1c6ea"
        ),
        .binaryTarget(
            name: "InfobipRTCBroadcastExtension",
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.12/InfobipRTCBroadcastExtension.zip",
            checksum: "4261e3786208fadcb988d39bbf4089d8db7bf13bc6c723c6943204059f53ef10"
        ),
        .binaryTarget(
            name: "IBWebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.44539/IBWebRTC.zip",
            checksum: "694fce2fba0ea2b50074c99453c296e797789f53b4743f91415a590251a457b2"
        )
    ]
)

