### Introduction
Infobip RTC is an iOS SDK which enables you to take advantage of Infobip's WebRTC platform. It gives you the ability to enrich your iOS applications with real-time communications in minimum time while focusing on your application's user experience and business logic. We currently support audio calls between two WebRTC users and phone calls between WebRTC user and actual phone device.

Here you will find an overview and quick guide on how to connect to Infobip WebRTC platform. There is also in-depth reference documentation available.

### First-time setup
In order to use Infobip RTC, you need to have WebRTC enabled on your account, and that's it! You are ready to make WebRTC calls. Please contact your account manager to enable WebRTC.

### Getting SDK
There are a few ways that you can get the distribution of our SDK. We publish it on Cocoapods and Carthage

If you want to add it as a Cocoapod dependency, add following to your Podfile:

```
pod 'InfobipRTC'
```

And then use it in your project like this:

```
import InfobipRTC
```

### Authentication
Since Infobip RTC is just SDK, it means you are developing your own application, and you only use Infobip RTC as a dependency. Your application has your own users, which we will call subscribers throughout this guide. So, in order to use Infobip RTC, you need to register your subscribers to our platform. Credentials your subscribers use to connect to your application are irrelevant to Infobip. We only need an identity for each subscriber. And when we have subscriber's identity, we can generate a token assigned to specific subscriber. With that token, your subscribers can connect to our platform (using Infobip RTC SDK).

In order to generate these tokens for your subscribers, you need to call our [`/webrtc/1/token`](https://dev.infobip.com/webrtc/generate-token) HTTP API method with proper parameters. Also, there you will authenticate yourself against Infobip platform, so we can relate the subscriber's token to you. Typically, generating token occurs after your subscribers are authenticated inside your application.
In response, you will receive the token, which enables you to make and receive call via  [`InfobipRTC`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC) client in your iOS application.


### Application Permissions
In order to use InfobipRTC in your application, _Record_ permission is required. Make sure _Record_ permission is requested before making any call.
Please check [official documentation](https://developer.apple.com/documentation/avfoundation/avaudiosession/1616601-requestrecordpermission?language=swift) for any help. 


### Making a call
You can call another WebRTC subscriber, if you know it's identity. It is done via [`call`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call) method:

```
let token = obtainToken()
let callRequest = CallRequest(token, destination: "Alice", callDelegate: self)
let outgoingCall = InfobipRTC.call(callRequest)
```

As you can see, [`call`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call) method returns instance of [`OutgoingCall`](https://github.com/infobip/infobip-rtc-ios/wiki/OutgoingCall) as a result. With it, you can track status of your call and invoke call actions. CallDelegate is passed as third param, so you can do something when called subscriber answers the call, rejects it, when call is ended, etc. You set-up call delegate with this code:

```
class RTCCallDelegate : CallDelegate {
    func onEstablished(_ callEstablishedEvent: CallEstablishedEvent) {
        os_log("Call established")
    }

    func onHangup(_ callHangupEvent: CallHangupEvent) {
        os_log("Call ended")
    }

    func onError(_ callErrorEvent: CallErrorEvent) {
        os_log("Call ended with error")
    }

    func onEarlyMedia(_ callEarlyMediaEvent: CallEarlyMediaEvent) {
        os_log("Received early media.")
    }
    
    func onRinging(_ callRingingEvent: CallRingingEvent) {
        os_log("Call is ringing.")
    }
}
```

When call delegate is set-up and call is established, there are few things that you can do with actual call. One of them, of course, is to hangup. That can be done via [`hangup`](https://github.com/infobip/infobip-rtc-ios/wiki/Call#hangup) method on call, and after that, both parties will receive `hangup` event upon hangup completion.

```
outgoingCall.hangup()
```

You can simulate digit press during the call, by sending DTMF codes (Dual-Tone Multi-Frequency). It is achieved via [`sendDTMF`](https://github.com/infobip/infobip-rtc-ios/wiki/Call#sendDTMF) method. Valid DTMF codes are digits `0`-`9`, `*` and `#`.

```
outgoingCall.sendDTMF('*')
```

During the call, you can also mute (and unmute) your audio:

```
outgoingCall.mute(true)
```
Or you can play media on speakerphone:
```
outgoingCall.speakerphone(true)
```
Also, you can check call status:
```
let status = outgoingCall.status
```
#### Calling phone number
It is very much similar to calling regular WebRTC user, you just use [`callPhoneNumber`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#callPhoneNumber) method instead [`call`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call). This method accepts optional second parameter, options in which you can define from parameter. It's value will display on calling phone device as Caller ID. Result of [`callPhoneNumber`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#callPhoneNumber) is also [`OutgoingCall`](https://github.com/infobip/infobip-rtc-ios/wiki/OutgoingCall) that you can do everything you could when using [`call`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call) method:

```
let callRequest = CallRequest(token, destination: "41793026727", callDelegate: self)
let outgoingCall = InfobipRTC.callPhoneNumber(callRequest, CallPhoneNumberOptions(from: "33755531044"))
```


### Receiving a call
In order to be able to receive incoming calls, your application needs to support several things:
* VoIP Background mode enabled - Xcode Project > Capabilites > Background Modes, make sure _Voice over IP_, _Background fetch_ and _Remote notifications_ options are checked.

* Push Notifications enabled - Xcode Project > Capabilites > Push Notifications

* Voip Services Certificate - Login to your apple developer account, find your app under _Identifiers_ option, enable Push Notifications and generate new certificate, following instructions from Apple. Go back to your MacBook and import generated certificate in your Keychain and then export it as .p12 file. Exported file will be used for sending push notifications later.


Once configuration is done, your application must register for push notifications and setup incoming call delegate using following code:
```
let voipRegistry = PKPushRegistry(queue: DispatchQueue.main)
voipRegistry.desiredPushTypes = [PKPushType.voIP]
voipRegistry.delegate = self

class MainController: PKPushRegistryDelegate, NotificationDelegate {
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        if type == .voIP {
            do {
                let token = obtainToken()
                try InfobipRTC.enablePushNotification(token, pushCredentials: pushCredentials)
            } catch {
                os_log("Failed to register for push: %@", error.localizedDescription)
            }
        }
    }
        
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        if type == .voIP {
            os_log("Received VoIP Push Notification %@", payload)
            InfobipRTC.handleIncomingCall(payload, notificationDelegate: self)
        }
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        do {
            let token = obtainToken()
            try InfobipRTC.disablePushNotification(token)
        } catch {
            os_log("Failed to disable push notifications.")
        }
    }
    
    func onIncomingCall(_ incomingCallEvent: IncomingCallEvent) {
        let incomingCall = incomingCallEvent.incomingCall
        incomingCall.delegate = CallDelegate()
        incomingCall.accept() // or incomingCall.decline()
    }
}
```


#### Receiving call on Simulator
Since Push notifications are not available on Simulator devices, in order to test incoming calls you can create active connection when your app launches:
```
let token = obtainToken()
InfobipRTC.startActiveConnection(token, notificationDelegate: self)
```
