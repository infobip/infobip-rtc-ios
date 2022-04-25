            // swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "InfobipRTC",
    products: [
        .library(name: "InfobipRTC", targets: ["InfobipRTC"])
    ],
    targets: [
        .binaryTarget(
            name: "InfobipRTC",
            url: "https://rtc.cdn.infobip.com/ios/1.4.52/InfobipRTC.xcframework.zip",
            checksum: "323fc9c8c59f81b920337e42983e3f7f3b8586d9a32642fbd56fd0b57a94ae69"
        )
    ]
)

            EOF
