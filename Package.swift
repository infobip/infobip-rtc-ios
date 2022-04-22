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
                url: "https://rtc.cdn.infobip.com/ios/1.4.42/InfobipRTC.xcframework.zip",
                checksum: "438fd4cb8334dc7e570428d63c339b4f0b301e4e4bb3cce9dece49b8afb57df6
"
              )
            ]
        )
        EOF
