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
            url: "https://rtc.cdn.infobip.com/ios/1.4.57/InfobipRTC.zip",
            checksum: "d82813da9a5d8b1138ae6246bbf40cf443d4e39bfa8e7dd81efaeeaed8841b1d"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.36511/WebRTC.zip",
            checksum: "5b43d98523ee53368974dcd26e88402c2f4190fc8ec0dfb02d13cc934d82141c"
        )
    ]
)

