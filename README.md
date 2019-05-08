### Introduction
Infobip RTC is iOS SDK which enables you to take advantage of Infobip's WebRTC platform. It gives you ability to enrich your web applications with real-time communications in minimum time, while focusing on your application's user experience and business logic. We currently support audio calls between two WebRTC users, and phone calls between WebRTC user and actual phone device.

Here you will find overview and quick guide how to connect to Infobip WebRTC platform. There is also in-depth reference documentation available.

### First time setup
In order to use Infobip RTC, you need to have WebRTC enabled on your account, and that's it! You are ready to make WebRTC calls. Please contact your account manager to enable WebRTC.

### Getting SDK
There are few ways that you can get distribution of our SDK. We publish it on Cocoapods and Carthage

If you want to add it as a Cocoapod dependency, add following to your Podfile:

```
pod 'InfobipRTC', '~> 0.0.13'
```

And then use it in your project like this:

```
import InfobipRTC
```

### Authentication
Since Infobip RTC is just SDK, it means you are developing your own application, and you only use Infobip RTC as dependency. Your application has your own users, which we wall call subscribers throughout this guide. So, in order to use Infobip RTC, you need to register your subscribers to our platform. Credentials your subscribers use to connect to your application are irrelevant to Infobip. We only need identity with which they will use to present themselves. And when we have their identity, we can generate token that you will assign for them to use. With that token, your subscribers can connect to our platform (using Infobip RTC SDK).

In order to generate these tokens for your subscribers, you need to call our [`/webrtc/token`](https://dev.infobip.com/webrtc/generate-token) HTTP API method with proper parameters. Also, there you will authenticate yourself against Infobip platform, so we can relate subscriber's token to you. Typically, generating token occurs after your subscribers are authenticated inside your application.
In response you will receive token, that you will use to instantiate [`InfobipRTC`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC) client in your web application.

### Infobip RTC Client
After you received token via HTTP API, you are ready to instantiate [`InfobipRTC`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC) client. It can be done using these commands:

```
let token = obtainToken()
let infobipRTC = DefaultInfobipRTC(token)
```

Note that this does not actually connect to Infobip WebRTC platform, it just creates new instance of [`InfobipRTC`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC). Connecting is done via [`connect`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC#connect) method. Before connecting, it is useful to set-up event handlers, so you can do something when connection is set-up, when connection is lost, etc. Events are set-up implementing RTCEventListener protocol:

```
class RTCDelegate : RTCEventListener {
    func onConnected(_ connectedEvent: ConnectedEvent) {
            print(String(format: "Connected with identity:  %@", connectedEvent.identity))
        }
        
    func onDisconnected(_ disconnectedEvent: DisconnectedEvent) {
        print(String(format: "Disconnected with reason: :  %@", disconnectedEvent.reason))
    }
    
    func onReconnecting(_ reconnectingEvent: ReconnectingEvent) {
    }
    
    func onReconnected(_ reconnectedEvent: ReconnectedEvent) {
    }
}
```

And then call [`addEventListener`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC#on) method:
```
infobipRTC.addEventListener(RTCDelegate())
```


Now you are ready to connect:

```
infobipRTC.connect();
```

### Making a call
You can call another WebRTC subscriber, if you know it's identity. It is done via [`call`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC#call) method:

```
let outgoingCall = infobipRTC.call('Alice', CallOptions(video: false));
```

As you can see, [`call`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC#call) method returns instance of [`OutgoingCall`](https://github.com/infobip/infobip-rtc-js/wiki/OutgoingCall) as a result. With it you can track status of your call and respond to events. Similar as for client, you can set-up event handlers, so you can do something when called subscriber answers the call, rejects it, when call is ended, etc. You set-up event handlers with this code:

```
class RTCCallDelegate : OutgoingCallEventListener {
    func onEstablished(_ callEstablishedEvent: CallEstablishedEvent) {
        os_log("Call established")
    }

    func onHangup(_ callHangupEvent: CallHangupEvent) {
        os_log("Call ended")
    }

    func onError(_ callErrorEvent: CallErrorEvent) {
        os_log("Call ended with error")
    }

    func onRinging(_ callRingingEvent: CallRingingEvent) {
        os_log("Call is ringing")
    }
}

outgoingCall.addEventListener(RTCCallDelegate)
```

When event handlers are set-up and call is established, there are few things that you can do with actual call. One of them, of course, is to hangup. That can be done via [`hangup`](https://github.com/infobip/infobip-rtc-js/wiki/Call#hangup) method on call, and after that, both parties will receive `hangup` event upon hangup completion.

```
outgoingCall.hangup();
```

You can simulate digit press during the call, by sending DTMF codes (Dual-Tone Multi-Frequency). It is achieved via [`sendDTMF`](https://github.com/infobip/infobip-rtc-js/wiki/Call#sendDTMF) method. Valid DTMF codes are digits `0`-`9`, `*` and `#`.

```
outgoingCall.sendDTMF('*');
```

During the call, you can also mute (and unmute) your audio:

```
outgoingCall.mute(true);
```

### Receiving a call
Besides making outgoing calls, you can also receive incoming calls. In order to do that, you need to implement `IncomingCallEventListener` delegate of [`InfobipRTC`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC) client. There you can define behavior on incoming call. One of the most common thing to do there is to show Accept and Decline options on some UI. For purposes of this guide, let's see example that answers incoming call as soon as it arrives:

```
class IncomingCallDelegate : IncomingCallEventListener {
    func onIncomingCall(_ incomingCallEvent: IncomingCallEvent) {
        let incomingCall = incomingCallEvent.incomingCall
        incomingCall.addEventListener(RTCCallDelegate())
        incomingCall.accept() // or incomingCall.decline()
    }
    
    func onMissedCall(_ missedCallEvent: MissedCallEvent) {
        print("Missed call from: \(missedCallEvent.caller)")
    }
}
infobipRTC.addIncomingCallEventListener(IncomingCallDelegate())
```

If you are in the middle of a call, naturally, you cannot receive second call. So, if someone makes incoming call to you while you are talking, `onMissedCall` delegate method will get invoked.

### Calling phone number
It is very much similar to calling regular WebRTC user, you just use [`callPhoneNumber`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC#callPhoneNumber) method instead [`call`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC#call). This method accepts optional second parameter, options in which you can define from parameter. It's value will display on calling phone device as Caller ID. Result of [`callPhoneNumber`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC#callPhoneNumber) is also [`OutgoingCall`](https://github.com/infobip/infobip-rtc-js/wiki/OutgoingCall) that you can do everything you could when using [`call`](https://github.com/infobip/infobip-rtc-js/wiki/InfobipRTC#call) method:

```
let outgoingCall = infobipRTC.callPhoneNumber("41793026727", CallPhoneNumberOptions(from: "33755531044"));
```
