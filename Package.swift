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
            url: "https://rtc.cdn.infobip.com/ios/2/2.3.11/InfobipRTC.zip",
            checksum: "03d98b44cbfa6254a5d780d7f8245aae7f802970b804da9e5b8ba2a47fd4cbee"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.40201/WebRTC.zip",
            checksum: "8ca9dcee15ef5acb7eab163651f47ccaab8eb6569367bbef9e1efedd6776942e"
        )
    ]
)

