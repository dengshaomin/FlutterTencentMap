package com.code.fluttertencentmap.flutter.nativeview

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.widget.FrameLayout
import android.widget.Toast
import com.code.fluttertencentmap.R
import kotlinx.android.synthetic.main.view_native_test.view.*

class NativeViewTest @JvmOverloads constructor(
    context: Context, attrs: AttributeSet? = null
) : FrameLayout(context, attrs) {
    init {
        LayoutInflater.from(context).inflate(R.layout.view_native_test, this)
        image.setOnClickListener {
            Toast.makeText(context, "native image click", Toast.LENGTH_SHORT).show()
        }
    }
}