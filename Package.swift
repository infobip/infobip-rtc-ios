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
            url: "https://rtc.cdn.infobip.com/ios/2/2.0.1/InfobipRTC.zip",
            checksum: "f5ef4618d92d6120f5916aa6de45d68b0217ab1ebe7ae5cfe5ca9326e732a724"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.37785/WebRTC.zip",
            checksum: "e790bc6d407cd9d3bd599d847f8e5f52f32d77d826afdc637f668cedfa544f22"
        )
    ]
)

