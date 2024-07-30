### Introduction

Infobip RTC is an iOS SDK which enables you to take advantage of Infobip platform, giving you the ability to enrich your
applications with real-time communications in minimum time, while you focus on your application's user experience and
business logic. We currently support WebRTC calls between two web or app users, phone calls between a web or app user
and user behind called phone number, Viber calls, calls to the Infobip Conversations platform, as well as room calls
which multiple participants can join.

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

There are several ways to install our SDK. We publish it on CocoaPods, Swift Package Manager and Carthage.

#### CocoaPods

If you want to add it as a CocoaPods dependency, add the following to your `Podfile`:

```ruby
pod 'InfobipRTC'
```

To install newly added dependencies, simply run `pod install`.

#### Swift Package Manager

If you want to install our SDK using Swift Package Manager, add the GitHub repository
`https://github.com/infobip/infobip-rtc-ios/` as a Swift Package.

#### Carthage

If you want to use Carthage dependency manager, add these dependencies to your `Cartfile`:

```ogdl
github "infobip/infobip-rtc-ios" ~> 2.0.0
binary "https://rtc.cdn.infobip.com/webrtc/ios/releases.json" >= 1.0.37785
```

When using it for the first time, run `carthage bootstrap --use-xcframeworks`. Otherwise,
run `carthage update --use-xcframeworks` to update dependencies.

Find `InfobipRTC.xcframework` in the `Carthage/Build` folder and drag and drop it in
the `Frameworks, Libraries, and Embedded Content` section of your application target's General settings.

#### Using the SDK

Once the SDK is installed, it is available for use in your project as:

```swift
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
[`/webrtc/1/token`](https://www.infobip.com/docs/api/channels/webrtc-calls/webrtc/generate-webrtc-token) HTTP API
endpoint using proper parameters. After you successfully authenticated your subscribers against Infobip platform, we can
relate their token to your application. Typically, generating a token occurs after your subscribers are authenticated
inside your application. You will receive the token in the response that you will use to make and receive calls via  
[`InfobipRTC`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC) client in your mobile application.

### Application Permissions

In order to use Infobip RTC in your application, it is required to grant following permissions:

#### _Record_ permission

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

#### _Camera_ permission

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

### Before you make and receive calls

Keep in mind that making and receiving calls on iOS requires you to
use [CallKit](https://developer.apple.com/documentation/callkit).
This enables you to display the system-calling UI and coordinate your calling services with other apps and the system.

### Getting an InfobipRTC instance

To utilize all the functionalities of InfobipRTC client, you need to obtain an instance of InfobipRTC.
This is done via calling a globally exposed
function [`getInfobipRTCInstance`](https://github.com/infobip/infobip-rtc-ios/wiki/Getting-InfobipRTC-Instance):

```swift
let infobipRTC = getInfobipRTCInstance()
```

### Making a WebRTC call

You can call another subscriber, if you know their identity. This is done via
the [`callWebrtc`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call-webrtc) method:

```swift
let token = obtainToken()
let infobipRTC = getInfobipRTCInstance()

let callWebrtcRequest = CallWebrtcRequest(token, destination: "Alice", webrtcCallEventListener: self)
let webrtcCall = infobipRTC.callWebrtc(callWebrtcRequest)
```

As you can see, the [`callWebrtc`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call-webrtc) method
returns an instance of [`WebrtCall`](https://github.com/infobip/infobip-rtc-ios/wiki/WebrtcCall) as a result. With it,
you can track the status of your call and respond to events, such as:

- called subscriber answered the call
- called subscriber rejected the call
- the call has ended

The `WebrtcCallEventListener`, passed as the third parameter, is used for receiving events from the SDK, and can be set
up using the following code:

```swift
class RTCWebrtcCallEventListener : WebrtcCallEventListener {
    func onRinging(_ callRingingEvent: CallRingingEvent) {
        os_log("Call is ringing.")
    }
    
    func onEarlyMedia(_ callEarlyMediaEvent: CallEarlyMediaEvent) {
        os_log("Received early media.")
    }
    
    func onEstablished(_ callEstablishedEvent: CallEstablishedEvent) {
        os_log("Call established.")
    }
    
    func onCameraVideoAdded(_ cameraVideoAddedEvent: CameraVideoAddedEvent) {
        os_log("Camera video added.")
    }
    
    func onCameraVideoUpdated(_ cameraVideoUpdatedEvent: CameraVideoUpdatedEvent) {
        os_log("Camera video updated.")
    }
    
    func onCameraVideoRemoved() {
        os_log("Camera video removed.")
    }
    
    func onScreenShareAdded(_ screenShareAddedEvent: ScreenShareAddedEvent) {
        os_log("Screen share added.")
    }
    
    func onScreenShareRemoved() {
        os_log("Screen share removed.")
    }
    
    func onRemoteCameraVideoAdded(_ cameraVideoAddedEvent: CameraVideoAddedEvent) {
        os_log("Remote camera video added.")
    }
    
    func onRemoteCameraVideoRemoved() {
        os_log("Remote camera video removed.")
    }
    
    func onRemoteScreenShareAdded(_ screenShareAddedEvent: ScreenShareAddedEvent) {
        os_log("Remote screen share added.")
    }
    
    func onRemoteScreenShareRemoved() {
        os_log("Remote screen share removed.")
    }
    
    func onRemoteMuted() {
        os_log("Remote endpoint muted.")
    }
    
    func onRemoteUnmuted() {
        os_log("Remote endpoint unmuted.")
    }
    
    func onHangup(_ callHangupEvent: CallHangupEvent) {
        os_log("Call ended.")
    }
    
    func onError(_ errorEvent: ErrorEvent) {
        os_log("An error has occurred.")
    }
}
```

When `WebrtcCallEventListener` is set up, and the call is established, there are a few things that you can do with the
actual call. One of them is to hang up the call, which can be done via
the [`hangup`](https://github.com/infobip/infobip-rtc-ios/wiki/Call#hangup) method. Upon completion, both endpoints will
receive the `CallHangupEvent`.

```swift
webrtcCall.hangup()
```

You can simulate digit press during the call by sending DTMF codes (Dual-Tone Multi-Frequency). This is achieved via
the [`sendDTMF`](https://github.com/infobip/infobip-rtc-ios/wiki/Call#send-dtmf) method. Valid DTMF codes are digits `0`
-`9`, letters `Á` to `D`, symbols `*` and `#`.

```swift
webrtcCall.sendDTMF('*')
```

During the call, you can also mute (and unmute) your audio:

```swift
webrtcCall.mute(true)
```

Or you can play media on the speakerphone:

```swift
webrtcCall.speakerphone(true)
```

_To have better control over all connected audio devices, such as bluetooth
headsets, check out
our [`audio device manager`](https://github.com/infobip/infobip-rtc-ios/wiki/Call#audioDeviceManager)_.

Also, you can check the call status:

```swift
let status = webrtcCall.status
```

#### Making a phone call

It is similar to calling a regular WebRTC user, you just use
the [`callPhone`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call-phone) method instead
of [`callWebrtc`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call-webrtc). This method accepts an
optional second parameter, where you define the `from` parameter. Its value will be displayed on the called phone as the
Caller ID. The result of the [`callPhone`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call-phone) is an
instance of [`PhoneCall`](https://github.com/infobip/infobip-rtc-ios/wiki/PhoneCall) on which you can do a several
actions, such as muting the call, hanging it up, checking its start time, answer time, duration and more.

```swift
let token = obtainToken()
let infobipRTC = getInfobipRTCInstance()
let callPhoneRequest = CallPhoneRequest(token, destination: "41793026727", phoneCallEventListener: self)
let phoneCallOptions = PhoneCallOptions(from: "33755531044")
let phoneCall = infobipRTC.callPhone(callPhoneRequest, phoneCallOptions)
```

#### Making a Viber call

Using the [`callViber`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call-viber) method is similar to
previously described methods. In this case, call's destination is Viber application. Unlike in
the [`callPhone`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call-phone) method, `from` is required and
is passed as part of the [`CallViberRequest`](https://github.com/infobip/infobip-rtc-ios/wiki/CallViberRequest).
Additionally, it has to be a Viber Voice number. The result of the
[`callViber`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#call-viber) is an instance of
[`ViberCall`](https://github.com/infobip/infobip-rtc-ios/wiki/ViberCall) on which you can do a several actions, such as
muting the call, hanging it up, checking its start time, answer time, duration and more.

```swift
let token = obtainToken()
let infobipRTC = getInfobipRTCInstance()
let callViberRequest = CallViberRequest(token, destination: "41793026727", from: "41727620397", viberCallEventListener: self)
let viberCall = infobipRTC.callViber(callViberRequest)
```

### Receiving a WebRTC call

> Note: In order for push notifications to work, they have to be enabled for your application, as explained in
> [the documentation](https://www.infobip.com/docs/voice-and-video/webrtc#declare-a-webrtc-application-getstartedwith-rtc-sdk).

In order to be able to receive incoming WebRTC calls, your application needs to support several things:

- VoIP Background mode enabled - `Xcode Project` > `Capabilites` > `Background Modes` and make sure the following
  options are checked:
    - `Voice over IP`
    - `Background fetch`
    - `Remote notifications`
- Push Notifications enabled - `Xcode Project` > `Capabilites` > `Push Notifications`
- Voip Services Certificate - Log into your Apple developer account, find your app under `Identifiers` option, enable
  Push Notifications and generate new certificate following the instructions from Apple. Go back to your MacBook and
  import the generated certificate in your Keychain and then export it as `.p12` file, which will be used later to send
  push notifications.

Once the configuration is done, your application must register for push notifications, and you have to set up the
`PKPushRegistryDelegate` and `WebrtcCallEventListener` using following code:

```swift
class MainController: PKPushRegistryDelegate, IncomingCallEventListener {
    private var voipRegistry: PKPushRegistry
    
    init() {
        voipRegistry = PKPushRegistry(queue: DispatchQueue.main)
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
        voipRegistry.delegate = self
    }
    
    var infobipRTC: InfobipRTC {
        get {
            return getInfobipRTCInstance()
        }
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        if type == .voIP {
            let token = obtainToken()
            let debug = isDebug()
            infobipRTC.enablePushNotification(token, pushCredentials: pushCredentials, debug: debug, pushConfigId: "454d142b-a1ad-239a-d231-227fa335aadc3")
        }
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        if type == .voIP {
            os_log("Received VoIP Push Notification %@", payload)
            if infobipRTC.isIncomingBasicCall(payload) {
                infobipRTC.handleIncomingCall(payload, self)
            }
        }
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        let token = obtainToken()
        infobipRTC.disablePushNotification(token)
    }
    
    func onIncomingWebrtcCall(_ incomingWebrtcCallEvent: IncomingWebrtcCallEvent) {
        let incomingWebrtcCall = incomingWebrtcCallEvent.incomingWebrtcCall
        // Don't forget to register this call to CallKit
        incomingWebrtcCall.webrtcCallEventListener = WebrtcCallListener(incomingWebrtcCall)
        incomingWebrtcCall.accept() // or incomingWebrtcCall.decline()
    }
    
    func isDebug() -> Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }
}

class WebrtcCallListener: WebrtcCallListener {
    let webrtcCall : WebrtcCall
    
    init(_ webrtcCall: WebrtcCall) {
        self.webrtcCall = webrtcCall
    }
    ...
}
```

#### Receiving a WebRTC call on Simulator

Since push notifications are not available on simulator devices, in order to test incoming calls you can create
InfobipSimulator instance when creating Push Registry:

```swift
let token = obtainToken()
var pushRegistry = InfobipSimulator(token: token)
```

### Joining a room call

You can join a room call with other WebRTC endpoints. The room call will start as soon as at least one participant
joins.

Room can be joined by up to 15 participants, simultaneously.

Joining the room is done via the [`joinRoom`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#join-room)
method:

```swift
let token = obtainToken()
let infobipRTC = getInfobipRTCInstance()

let roomCallRequest = RoomCallRequest(token, roomName: "room-demo", roomCallEventListener: self)
let room = infobipRTC.joinRoom(roomCallRequest)
```

As you can see, the [`joinRoom`](https://github.com/infobip/infobip-rtc-ios/wiki/InfobipRTC#join-room) method returns an
instance of [`RoomCall`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCall) as a result. With it, you can track
the status of your room call and respond to events, such as:

- another participant joined the room
- participant left the room
- participant muted/unmuted

The `RoomCallEventListener`, passed as the third parameter, is used for receiving events from the SDK, and can be set up
using the following code:

```swift
class RTCRoomCallEventListener: RoomCallEventListener {    
    func onError(_ errorEvent: ErrorEvent) {
        os_log("An error has occurred.")
    }
    
    func onRoomJoined(_ roomJoinedEvent: RoomJoinedEvent) {
        os_log("You have joined the room.")
    }
    
    func onRoomLeft(_ roomLeftEvent: RoomLeftEvent) {
        os_log("You have left the room.")
    }
    
    func onParticipantJoining(_ participantJoiningEvent: ParticipantJoiningEvent) {
        os_log("Participant joining the room.")
    }
    
    func onParticipantJoined(_ participantJoinedEvent: ParticipantJoinedEvent) {
        os_log("Participant joined the room.")
    }
    
    func onParticipantLeft(_ participantLeftEvent : ParticipantLeftEvent) {
        os_log("Participant left the room.")
    }
    
    func onParticipantMuted(_ participantMutedEvent: ParticipantMutedEvent) {
        os_log("Participant muted themself.")
    }
    
    func onParticipantUnmuted(_ participantUnmutedEvent: ParticipantUnmutedEvent) {
        os_log("Participant unmuted themself.")
    }
    
    func onParticipantDeaf(_ participantDeafEvent: ParticipantDeafEvent) {
        os_log("Participant deafened themself.")
    }
    
    func onParticipantUndeaf(_ participantUndeafEvent: ParticipantUndeafEvent) {
        os_log("Participant undeafened themself.")
    }
    
    func onParticipantStartedTalking(_ participantStartedTalkingEvent: ParticipantStartedTalkingEvent) {
        os_log("Participant started talking.")
    }
    
    func onParticipantStoppedTalking(_ participantStoppedTalkingEvent: ParticipantStoppedTalkingEvent) {
        os_log("Participant stopped talking.")
    }
   
    func onCameraVideoAdded(_ cameraVideoAddedEvent: CameraVideoAddedEvent) {
       os_log("Camera video added.")
    }
    
    func onCameraVideoUpdated(_ cameraVideoUpdatedEvent: CameraVideoUpdatedEvent) {
       os_log("Camera video updated.")
    }
    
    func onCameraVideoRemoved() {
       os_log("Camera video removed.")
    }
    
    func onScreenShareAdded(_ screenShareAddedEvent: ScreenShareAddedEvent) {
       os_log("Screen share started.")
    }
    
    func onScreenShareRemoved() {
       os_log("Screen share stopped.")
    }
    
    func onParticipantCameraVideoAdded(_ participantCameraVideoAddedEvent: ParticipantCameraVideoAddedEvent) {
       os_log("Participant added camera video.")
    }
    
    func onParticipantCameraVideoRemoved(_ participantCameraVideoRemovedEvent: ParticipantCameraVideoRemovedEvent) {
       os_log("Participant removed camera video.")
    }
    
    func onParticipantScreenShareAdded(_ participantScreenShareAddedEvent: ParticipantScreenShareAddedEvent) {
       os_log("Participant started screen share.")
    }
    
    func onParticipantScreenShareRemoved(_ participantScreenShareRemovedEvent: ParticipantScreenShareRemovedEvent) {
       os_log("Participant stopped screen share.")
    }
}
```

When `RoomCallEventListener` is set up, and you joined the room, there are a few things that you can do with the
actual room call.

One of them is to leave, which can be done via
the [`leave`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCall#leave) method. Upon completion,  
[`onParticipantLeft`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-participant-left) method
will be triggered for the remaining participants in the room call, and for you,  
[`onRoomLeft`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-room-left) method will be
triggered.

```swift
roomCall.leave()
```

During the room call, you can also mute/unmute your audio, by calling
the [`mute`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCall#mute) method. Upon completion,
[`onParticipantMuted`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-participant-muted)
/ [`onParticipantUnmuted`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-participant-unmuted)
method will be triggered for other participants in the room call.

```swift
roomCall.mute(true)
```

To check if the audio is muted, call the [`muted`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCall#muted)
method in the following way:

```swift
let audioMuted = roomCall.muted()
```

Also, you can enable/disable your camera video, by calling
the [`cameraVideo`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCall#camera-video) method. Upon completion,
[`onParticipantCameraVideoAdded`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-participant-camera-video-added)
/ [`onParticipantCameraVideoRemoved`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-participant-camera-video-removed)
method will be triggered for other participants in the room call, while for you,
[`onCameraVideoAdded`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-camera-video-added)
/ [`onCameraVideoRemoved`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-camera-video-removed)
method will be triggered.

```swift
roomCall.cameraVideo(cameraVideo: true)
```

You can start/stop sharing your screen, by calling
the [`screenShare`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCall#screen-share) method. Upon completion,
[`onParticipantScreenShareAdded`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-participant-screen-share-added)
/ [`onParticipantScreenShareRemoved`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-participant-screen-share-removed)
method will be triggered for other participants in the room call, while for you,
[`onScreenShareAdded`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-screen-share-added)
/ [`onScreenShareRemoved`](https://github.com/infobip/infobip-rtc-ios/wiki/RoomCallEventListener#on-screen-share-removed)
method will be triggered.

```swift
roomCall.screenShare(screenShare: true)
```
