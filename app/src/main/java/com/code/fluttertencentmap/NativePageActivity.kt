package com.code.fluttertencentmap

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import io.flutter.embedding.android.FlutterActivity

class NativePageActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native_page)
    }

    fun openFlutterPage(view: View) {
        FlutterActivity.withNewEngine().initialRoute("test_page_0").build(this)
    }
}