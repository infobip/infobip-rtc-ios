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
            url: "https://rtc.cdn.infobip.com/ios/2/2.3.10/InfobipRTC.zip",
            checksum: "743be2b04ba381f6fe9420b531987c3b4de23a0e6eb92e92a3a017ecf5cccc0b"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.40201/WebRTC.zip",
            checksum: "8ca9dcee15ef5acb7eab163651f47ccaab8eb6569367bbef9e1efedd6776942e"
        )
    ]
)

