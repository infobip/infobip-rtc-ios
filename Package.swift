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
            url: "https://rtc.cdn.infobip.com/ios/1.4.56/InfobipRTC.zip",
            checksum: "78b085fedbd3ef7f6b1c84e35aea45cdfb655fafbd18f95e33dba4e0f87bb360"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.36511/WebRTC.zip",
            checksum: "5b43d98523ee53368974dcd26e88402c2f4190fc8ec0dfb02d13cc934d82141c"
        )
    ]
)

