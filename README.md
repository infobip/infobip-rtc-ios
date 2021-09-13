### Introduction

Infobip RTC is an iOS SDK which enables you to take advantage of Infobip platform, giving you the ability to enrich your
applications with real-time communications in minimum time, while you focus on your application's user experience and
business logic. We currently support audio and video calls between two web or app users, and phone calls between web or
app user and actual phone device.

Here you will find an overview and a quick guide on how to connect to Infobip platform. There is also in-depth reference
documentation available [here](https://github.com/infobip/infobip-rtc-ios/wiki).

### First-time setup

In order to use Infobip RTC, you need to have Web and In-app Calls enabled on your account and that's it! You are ready
to make Web and In-app calls. To learn how to enable them
see [the documentation](https://www.infobip.com/docs/voice-and-video/web-and-in-app-calls#set-up-web-and-in-app-calls).

### System Requirements

The Infobip RTC iOS SDK is supported on iOS 10.0 or above.

Supported Swift version is 5.1 or above.

### Getting the SDK

There are few ways that you can get our SDK. We publish it on CocoaPods and Carthage.

If you want to add it as a CocoaPod dependency, add the following to your Podfile:

```
pod 'InfobipRTC'
```

If you want to use Carthage dependency manager, add these dependencies to your Cartfile:

```
github "infobip/infobip-rtc-ios" ~> 1.3.0
binary "https://rtc.cdn.infobip.com/webrtc/ios/releases.json" >= 1.0.31369
```

After which you would use it in your project like this:

```
import InfobipRTC
```

### Authentication

Since Infobip RTC is an SDK, it means you develop your own application, and you only use Infobip RTC as a dependency. We
will refer to your application users as subscribers throughout this guide. So, in order to use Infobip RTC, you need to
register your subscribers on our platform. The credentials your subscribers use to connect to your application are
irrelevant to Infobip. We only need the identity they will use to present themselves on our platform. When we have the
subscriber's identity, we can generate a token assigned to that specific subscriber. Using that token, your subscribers
are able to connect to our platform (using Infobip RTC SDK).

To generate these tokens for your subscribers, you need to call our
[`/webrtc/1/token`](https://www.infobip.com/docs/api#channels/webrtc/generate-webrtc-token) HTTP API endpoint using
proper parameters. After you successfully authenticated your subscribers against Infobip platform, we can relate their
token to your application. Typically, generating a token occurs after your subscribers are authenticated inside your
application. You will receive the token in the response that you will use to make and receive calls via  
[`InfobipRTC`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC) client in your mobile application.

### Application Permissions

In order to use Infobip RTC in your application, it is required to grant following permissions:

###### _Record_ permission

Before making any call, make sure to request permission to record.

Example:

```swift
AVAudioSession.sharedInstance().requestRecordPermission { granted in
    if granted {
        // The user granted access. Present recording interface.
    }
}
```

Please check
the [official documentation](https://developer.apple.com/documentation/avfoundation/avaudiosession/1616601-requestrecordpermission?language=swift)
for additional details.

###### _Camera_ permission

Make sure _Camera_ permission is requested before making or switching to video call.

Example:

```swift
AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in 
    if granted {
        // The user granted access. Present camera interface.
    }
}
```

Please check
the [official documentation](https://developer.apple.com/documentation/avfoundation/avcapturedevice/1624584-requestaccess?language=swift)
for additional details.

### Making a call

You can call another WebRTC subscriber, if you know their identity. This is done via
the [`call`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call) method:

```swift
let token = obtainToken()
let callRequest = CallRequest(token, destination: "Alice", callDelegate: self)
let outgoingCall = InfobipRTC.call(callRequest)
```

As you can see, the [`call`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call) method returns an instance
of [`OutgoingCall`](https://github.com/infobip/infobip-rtc-ios/wiki/OutgoingCall) as a result. With it, you can track
the status of your call and respond to events, such as:

* called subscriber answered the call
* called subscriber rejected the call
* the call has ended

The `CallDelegate`, passed as the third parameter, is used for receiving events from the SDK, and can be set up using
the following code:

```swift
class RTCCallDelegate : CallDelegate {
    func onRinging(_ callRingingEvent: CallRingingEvent) {
        os_log("Call is ringing.")
    }
    
    func onEarlyMedia(_ callEarlyMediaEvent: CallEarlyMediaEvent) {
        os_log("Received early media.")
    }
    
    func onEstablished(_ callEstablishedEvent: CallEstablishedEvent) {
        os_log("Call established.")
    }
    
    func onUpdated(_ callUpdatedEvent: CallUpdatedEvent) {
        os_log("Call updated.")
    }
    
    func onHangup(_ callHangupEvent: CallHangupEvent) {
        os_log("Call ended.")
    }
    
    func onError(_ callErrorEvent: CallErrorEvent) {
        os_log("Call ended with error.")
    }
}
```

When `CallDelegate` is set up, and the call is established, there are a few things that you can do with the actual call.
One of them is to hang up the call, which can be done via
the [`hangup`](https://github.com/infobip/infobip-rtc-ios/wiki/Call#hangup) method. Upon completion, both parties will
receive the `hangup` event.

```swift
outgoingCall.hangup()
```

You can simulate digit press during the call by sending DTMF codes (Dual-Tone Multi-Frequency). This is achieved via
the [`sendDTMF`](https://github.com/infobip/infobip-rtc-ios/wiki/Call#sendDTMF) method. Valid DTMF codes are digits `0`
-`9`, letters `Á` to `D`, symbols `*` and `#`.

```swift
outgoingCall.sendDTMF('*')
```

During the call, you can also mute (and unmute) your audio:

```swift
outgoingCall.mute(true)
```

Or you can play media on the speakerphone:

```swift
outgoingCall.speakerphone(true)
```

Also, you can check the call status:

```swift
let status = outgoingCall.status
```

#### Calling phone number

It is similar to calling a regular WebRTC user, you just use
the [`callPhoneNumber`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#callPhoneNumber) method instead
of [`call`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call). This method accepts an optional second
parameter, where you define the `from` parameter. Its value will be displayed on the called phone as the Caller ID. The
result of the [`callPhoneNumber`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#callPhoneNumber) is also an
instance of [`OutgoingCall`](https://github.com/infobip/infobip-rtc-ios/wiki/OutgoingCall) with which you can do
everything described earlier.

```swift
let callRequest = CallRequest(token, destination: "41793026727", callDelegate: self)
let outgoingCall = InfobipRTC.callPhoneNumber(callRequest, CallPhoneNumberOptions(from: "33755531044"))
```

### Receiving a call

In order to be able to receive incoming calls, your application needs to support several things:

* VoIP Background mode enabled - `Xcode Project` > `Capabilites`> `Background Modes` and make sure the following options
  are checked:
    + `Voice over IP`
    + `Background fetch`
    + `Remote notifications`
* Push Notifications enabled - `Xcode Project` > `Capabilites` > `Push Notifications`
* Voip Services Certificate - Log into your Apple developer account, find your app under `Identifiers` option, enable
  Push Notifications and generate new certificate following the instructions from Apple. Go back to your MacBook and
  import the generated certificate in your Keychain and then export it as `.p12` file, which will be used later to send
  push notifications.

Once the configuration is done, your application must register for push notifications, and you have to set up the
incoming call delegate using following code:

```swift
let voipRegistry = PKPushRegistry(queue: DispatchQueue.main)
voipRegistry.desiredPushTypes = [PKPushType.voIP]
voipRegistry.delegate = self

class MainController: PKPushRegistryDelegate, NotificationDelegate {
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        if type == .voIP {
            do {
                let token = obtainToken()
                #if DEBUG
                    try InfobipRTC.enablePushNotification(token, pushCredentials: pushCredentials, debug: true)
                #else
                    try InfobipRTC.enablePushNotification(token, pushCredentials: pushCredentials)
                #endif
            } catch {
                os_log("Failed to register for push: %@", error.localizedDescription)
            }
        }
    }
        
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        if type == .voIP {
            os_log("Received VoIP Push Notification %@", payload)
            if var incomingCall = InfobipRTC.handleIncomingCall(payload) {
                incomingCall.delegate = self
                incomingCall.accept() // or incomingCall.decline()
            }
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
}
```

#### Receiving a call on Simulator

Since push notifications are not available on simulator devices, in order to test incoming calls you can create
InfobipSimulator instance when creating Push Registry:

```swift
let token = obtainToken()
var pushRegistry = InfobipSimulator(token: token)
```

### Conference call

You can have a conference call with other WebRTC subscribers. The conference call will start as soon as at least one
participant joins.

Conference call is in the beta stage and available for audio only, with a maximum limit of 12 participants.

Joining the room is done via
the [`joinConference`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#joinConference) method:

```swift
let token = obtainToken()
let conferenceRequest = ConferenceRequest(token, conferenceId: "conference-demo", conferenceDelegate: self)
let conference = InfobipRTC.joinConference(conferenceRequest)
```

As you can see, the [`joinConference`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#joinConference) method
returns an instance of [`Conference`](https://github.com/infobip/infobip-rtc-ios/wiki/Conference) as a result. With it,
you can track the status of your conference call and respond to events, such as:

* another user joined the conference
* user left the conference
* user muted/unmuted

The `ConferenceDelegate`, passed as the third parameter, is used for receiving events from the SDK, and can be set up
using the following code:

```swift
class RTCConferenceDelegate: ConferenceDelegate {
    func onJoined(joinedEvent: JoinedEvent) {
        os_log("You have joined the conference.")
    }
    
    func onLeft(leftEvent: LeftEvent) {
        os_log("You have left the conference.")
    }
    
    func onUserJoined(userJoinedEvent: UserJoinedEvent) {
        os_log("User joined the conference.")
    }
    
    func onUserLeft(userLeftEvent: UserLeftEvent) {
        os_log("User left the conference.")
    }
    
    func onUserMuted(userMutedEvent: UserMutedEvent) {
        os_log("User muted themself.")
    }
    
    func onUserUnmuted(userUnmutedEvent: UserUnmutedEvent) {
        os_log("User unmuted themself.")
    }
   
    func onLocalCameraVideoAdded(localCameraVideoAddedEvent: LocalVideoAddedEvent) {
       os_log("Camera video added.")
    }
    
    func onLocalScreenShareAdded(localScreenShareAddedEvent: LocalVideoAddedEvent) {
       os_log("Screen share started.")
    }
    
    func onLocalCameraVideoRemoved() {
       os_log("Camera video removed.")
    }
    
    func onLocalScreenShareRemoved() {
       os_log("Screen share stopped.")
    }
    
    func onUserCameraVideoAdded(userCameraVideoAddedEvent: UserCameraVideoAddedEvent) {
       os_log("User added camera video.")
    }
    
    func onUserCameraVideoRemoved(userCameraVideoRemovedEvent: UserCameraVideoRemovedEvent) {
       os_log("User removed camera video.")
    }
    
    func onUserScreenShareAdded(userScreenShareAddedEvent: UserScreenShareAddedEvent) {
       os_log("User started screen share.")
    }
    
    func onUserScreenShareRemoved(userScreenShareRemovedEvent: UserScreenShareRemovedEvent) {
       os_log("User stopped screen share.")
    }
    
    func onError(errorEvent: ErrorEvent) {
        os_log("Conference error occured.")
    }
}
```

When `ConferenceDelegate` is set up, and you joined the conference, there are a few things that you can do with the
actual conference call.

One of them is to leave, which can be done via
the [`leave`](https://github.com/infobip/infobip-rtc-ios/wiki/Conference#leave) method. Upon completion, other remaining
participants in the conference will receive
the [`onUserLeft`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onUserLeft) event, and you will
receive the [`onLeft`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onLeft) event.

```swift
conference.leave()
```

During the conference call, you can also mute/unmute your audio, by calling
the [`mute`](https://github.com/infobip/infobip-rtc-ios/wiki/Conference#mute) method. Upon completion, other
participants in the conference room will receive
the [`onUserMuted`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onUserMuted)
/ [`onUserUnmuted`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onUserUnmuted)
event.

```swift
conference.mute(true)
```

To check if the audio is muted, call the [`muted`](https://github.com/infobip/infobip-rtc-ios/wiki/Conference#muted)
method in the following way:

```swift
let audioMuted = conference.muted()
```

Also, you can enable/disable your camera video, by calling
the [`cameraVideo`](https://github.com/infobip/infobip-rtc-ios/wiki/Conference#cameraVideo) method. Upon completion,
other participants in the conference room will receive
the [`onUserCameraVideoAdded`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onUserCameraVideoAdded)
/ [`onUserCameraVideoRemoved`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onUserCameraVideoRemoved)
event, and you will receive
the [`onLocalCameraVideoAdded`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onLocalCameraVideoAdded)
/ [`onLocalCameraVideoRemoved`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onLocalCameraVideoRemoved)
event.

```swift
conference.cameraVideo(cameraVideo: true)
```

You can start/stop sharing your screen, by calling
the [`screenShare`](https://github.com/infobip/infobip-rtc-ios/wiki/Conference#screenShare) method. Upon completion,
other participants in the conference room will receive
the [`onUserScreenShareAdded`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onUserScreenShareAdded)
/ [`onUserScreenShareRemoved`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onUserScreenShareRemoved)
event, and you will receive
the [`onLocalScreenShareAdded`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onLocalScreenShareAdded)
/ [`onLocalScreenShareRemoved`](https://github.com/infobip/infobip-rtc-ios/wiki/ConferenceDelegate#onLocalScreenShareRemoved)
event.

```swift
conference.screenShare(screenShare: true)
```
