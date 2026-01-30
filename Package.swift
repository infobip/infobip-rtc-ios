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
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.8/InfobipRTC.zip",
            checksum: "eb5f99244bef9799c26d7842529ea7319f72993eee34b9317d1960bd25b4caac"
        ),
        .binaryTarget(
            name: "InfobipRTCBroadcastExtension",
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.8/InfobipRTCBroadcastExtension.zip",
            checksum: "53d7f431de4e05113fc4c853374ad4523448ab760b529f4604ca1ff66cba240e"
        ),
        .binaryTarget(
            name: "IBWebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.44539/IBWebRTC.zip",
            checksum: "694fce2fba0ea2b50074c99453c296e797789f53b4743f91415a590251a457b2"
        )
    ]
)

