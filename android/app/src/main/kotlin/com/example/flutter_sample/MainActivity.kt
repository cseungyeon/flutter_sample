package com.example.flutter_sample

import MessageApi
import MessageData
import android.content.res.Configuration
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.lifecycle.lifecycleScope
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugins.GeneratedPluginRegistrant
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val binaryMessenger = flutterEngine.dartExecutor.binaryMessenger

        // MessageChannel 설정
        val messageChannel =
            BasicMessageChannel(binaryMessenger, MESSAGE_CHANNEL, StringCodec.INSTANCE)
        messageChannel.setMessageHandler { message, reply ->
            // Flutter로 메시지 전송
            Log.d(TAG, "onConfigurationChanged: $message")
            reply.reply("플러터에서 받은 메시지(Android): $message")
        }

        // EventChannel 설정
        EventChannel(binaryMessenger, EVENT_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                    // 네이티브에서 Flutter로 이벤트 전송
                    val handler = Handler(Looper.getMainLooper())
                    for (count in 1 ..9) {
                        handler.postDelayed({
                            events.success("Event from Android $count")
                        }, 1000L * count)
                    }
                }

                override fun onCancel(arguments: Any?) {
                    // 이벤트 채널 구독 취소 시 처리
                    Log.d(TAG, "EventChannel onCancel()")
                }
            }
        )
    }

    companion object {
        private const val EVENT_CHANNEL = "com.example.flutter_sample/events"
        private const val MESSAGE_CHANNEL = "com.example.flutter_sample/message"
        private const val TAG = "ManActivity"
    }
}

class Message : MessageApi {
    override fun getHostLanguage(): String = "Android"

    override fun sendMessage(message: MessageData, callback: (Result<Boolean>) -> Unit) {
    }
}