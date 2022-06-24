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
            url: "https://rtc.cdn.infobip.com/ios/1.4.54/InfobipRTC.zip",
            checksum: "55f6a1d5f72fbce556ee7910dc88b2299f8758e3ad5097999955f5d9badd1119"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.36511/WebRTC.zip",
            checksum: "5b43d98523ee53368974dcd26e88402c2f4190fc8ec0dfb02d13cc934d82141c"
        )
    ]
)

