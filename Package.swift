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
            url: "https://rtc.cdn.infobip.com/ios/2/2.0.18/InfobipRTC.zip",
            checksum: "e99e2c30819396b171b656606129f89c0fcea809c52b664f49434b628460e7b6"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.37785/WebRTC.zip",
            checksum: "e790bc6d407cd9d3bd599d847f8e5f52f32d77d826afdc637f668cedfa544f22"
        )
    ]
)

