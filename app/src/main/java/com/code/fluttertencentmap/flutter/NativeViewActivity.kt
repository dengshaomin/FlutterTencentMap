package com.code.fluttertencentmap.flutter

import android.os.Bundle
import com.code.fluttertencentmap.flutter.NativeViewPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class NativeViewActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(NativeViewPlugin())
    }
    fun getInternalEngine():FlutterEngine?{
        return flutterEngine
    }

    override fun getInitialRoute(): String? {
        return "test_page_0"
    }
}