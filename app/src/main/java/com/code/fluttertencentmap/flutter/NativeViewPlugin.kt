package com.code.fluttertencentmap.flutter

import androidx.lifecycle.Lifecycle
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.lifecycle.HiddenLifecycleReference
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class NativeViewPlugin : FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler,
    EventChannel.StreamHandler {
    private var lifecycle: Lifecycle? = null
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private var eventSink: EventChannel.EventSink? = null
    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        binding.platformViewRegistry.registerViewFactory(
            NativeViewFactory.NativeViewType,
            NativeViewFactory(object : LifecycleProvider {
                override fun getLifecycle(): Lifecycle? {
                    return lifecycle
                }
            })
        )
        methodChannel =
            MethodChannel(binding.binaryMessenger, MapMethodConstants.METHOD_EVENT_CHANNEL)
        methodChannel.setMethodCallHandler(this)
//        eventChannel =
//            EventChannel(binding.binaryMessenger, MapMethodConstants.METHOD_EVENT_CHANNEL)
//        eventChannel.setStreamHandler(this)
        GlobalScope.launch {
            delay(1000)
            launch(Dispatchers.Main) {
                val result = methodChannel.invokeMethod(
                    MapMethodConstants.CALL_FLUTTER.GET_FLUTTER_RESOURCE,
                    mutableMapOf<String,Any>().apply {
                        put("platform","android")
                    },object :MethodChannel.Result{
                        override fun success(result: Any?) {
                            val a = 1
                        }

                        override fun error(
                            errorCode: String,
                            errorMessage: String?,
                            errorDetails: Any?
                        ) {
                            val a = 1
                        }


                        override fun notImplemented() {
                            val a= 1
                        }
                    }
                )
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        lifecycle = (binding.lifecycle as HiddenLifecycleReference).lifecycle
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        lifecycle = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        var rb: Any? = null
        when (call.method) {
            MapMethodConstants.CALL_NATIVE.GET_NATIVE_RESOURCE -> {
                rb = "{\"data\":\"fuck\"}"
            }
            MapMethodConstants.CALL_NATIVE.OPEN_NATIVE_PAGE->{
                val path = call.arguments
                when(path){
                    MapMethodConstants.NATIVE_PAGE_PATH.NATIVE_PAGE_ACTIVITY->{

                    }
                }
            }
        }
        result.success(rb)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null

    }
}