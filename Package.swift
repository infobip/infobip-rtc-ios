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
            name: "IBWebRTC",
            targets: ["IBWebRTC"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "InfobipRTC",
            url: "https://rtc.cdn.infobip.com/ios/2/2.6.6/InfobipRTC.zip",
            checksum: "6358710eb419cb57eb06585a7a17fdcb21347046ad322fed4492ddbd69b232de"
        ),
        .binaryTarget(
            name: "IBWebRTC",
            url: "https://rtc.cdn.infobip.com/webrtc/ios/1.0.44539/IBWebRTC.zip",
            checksum: "694fce2fba0ea2b50074c99453c296e797789f53b4743f91415a590251a457b2"
        )
    ]
)

