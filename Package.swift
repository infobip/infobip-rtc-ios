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
            url: "https://rtc.cdn.infobip.com/ios/2/2.5.0/InfobipRTC.zip",
            checksum: "d4286fbdb2c8dbabbffed2e4acf8dc7b41454199ab7fb9a79dae42d22d73798e"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.40201/WebRTC.zip",
            checksum: "8ca9dcee15ef5acb7eab163651f47ccaab8eb6569367bbef9e1efedd6776942e"
        )
    ]
)

