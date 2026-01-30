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
            checksum: "9352f679d38060af0ec692226b8f21ca29996d71429544882832e92a57903c33"
        ),
        .binaryTarget(
            name: "InfobipRTCBroadcastExtension",
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.8/InfobipRTCBroadcastExtension.zip",
            checksum: "e6bb18f16b39e55c45f43e4aa1cec74c08de5dc7d7b1bd5fb795a5842ef6b54c"
        ),
        .binaryTarget(
            name: "IBWebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.44539/IBWebRTC.zip",
            checksum: "694fce2fba0ea2b50074c99453c296e797789f53b4743f91415a590251a457b2"
        )
    ]
)

