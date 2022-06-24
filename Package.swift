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
            url: "https://rtc.cdn.infobip.com/ios/1.4.53/InfobipRTC.zip",
            checksum: "a0f281a28532afb037c25b08d02a57e71ec60e9e89f3baaf1a6cfe5440e55ced"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.36511/WebRTC.zip",
            checksum: "5b43d98523ee53368974dcd26e88402c2f4190fc8ec0dfb02d13cc934d82141c"
        )
    ]
)

