package com.code.fluttertencentmap

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.widget.FrameLayout

class MarkerView @JvmOverloads constructor(
    context: Context, attrs: AttributeSet? = null
) : FrameLayout(context, attrs) {
    init {
        LayoutInflater.from(context).inflate(R.layout.view_marker,this)
    }
}