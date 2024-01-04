import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let messageChannel = FlutterBasicMessageChannel(name: "com.example.flutter_sample/message", binaryMessenger: controller.binaryMessenger, codec: FlutterStringCodec.sharedInstance())
        messageChannel.setMessageHandler { (message, reply) in
            // Flutter로 response 메시지 전송
            reply("플러터에서 받은 메시지(iOS): \(message ?? "")")
        }
        
        // EventChannel 설정
        let eventChannel = FlutterEventChannel(name: "com.example.flutter_sample/events", binaryMessenger: controller.binaryMessenger)
        eventChannel.setStreamHandler(
            FlutterStreamHandlerExample()
        )
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

class FlutterStreamHandlerExample: NSObject, FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        // 네이티브에서 Flutter로 이벤트 전송
        events("Event from iOS")
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        // 이벤트 채널 구독 취소 시 처리
        return nil
    }
}
