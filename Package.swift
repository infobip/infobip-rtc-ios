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
            url: "https://rtc.cdn.infobip.com/ios/1.5.11/InfobipRTC.zip",
            checksum: "97c206a81610fa542ca0d3071615e5421dba62d454c491398aa42407643cfb5c"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.37785/WebRTC.zip",
            checksum: "e790bc6d407cd9d3bd599d847f8e5f52f32d77d826afdc637f668cedfa544f22"
        )
    ]
)

