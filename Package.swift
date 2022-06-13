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
            url: "https://rtc.cdn.infobip.com/ios/1.4.52/InfobipRTC.zip",
            checksum: "7f694a6236e020339535f325bfd62bcdb8428287de19e563d9e0a423a8b97d50"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.36136/WebRTC.zip",
            checksum: "7026768e4a540906fa6640f75f3d659c68641a2737d00e7da862ad733b9dbc05"
        )
    ]
)

