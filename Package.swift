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
            url: "https://rtc.cdn.infobip.com/ios/1.4.55/InfobipRTC.zip",
            checksum: "3905d59ec66fe60c9e9893b93a5bb22c05f476247024cd65e24fe6bb22234ebb"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.36511/WebRTC.zip",
            checksum: "5b43d98523ee53368974dcd26e88402c2f4190fc8ec0dfb02d13cc934d82141c"
        )
    ]
)

