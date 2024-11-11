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
            url: "https://rtc.cdn.infobip.com/ios/2/2.4.3/InfobipRTC.zip",
            checksum: "8dca807db0adf4267a800cb290db0a4bf936bf421f7d3eb45f3d76810158ffbf"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.40201/WebRTC.zip",
            checksum: "8ca9dcee15ef5acb7eab163651f47ccaab8eb6569367bbef9e1efedd6776942e"
        )
    ]
)

