// swift-tools-version:5.2
import PackageDescription
let package = Package(
    name: "InfobipRTC",
    products: [
        .library(name: "InfobipRTC", targets: ["InfobipRTC"])
    ],
    targets: [
        .target(name: "InfobipRTC", url: "https://rtc.cdn.infobip.com/ios/1.4.36/InfobipRTC.xcframework.zip", checksum: c87dbbc2c88e8ed2e38f4162646f084cd70041fead68bfd770d7a74e1a942b90
)
    ]
)
