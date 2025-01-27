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
            url: "https://rtc.cdn.infobip.com/ios/2/2.4.6/InfobipRTC.zip",
            checksum: "f2790755713f5c81097dc3ee5fd857b0e67c4c5da747e2c95dd74de39649f97d"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.40201/WebRTC.zip",
            checksum: "8ca9dcee15ef5acb7eab163651f47ccaab8eb6569367bbef9e1efedd6776942e"
        )
    ]
)

