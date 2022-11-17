package com.code.fluttertencentmap.flutter

import android.view.View
import io.flutter.plugin.platform.PlatformView

class NativeViewContainer(var nativeView:View):PlatformView {
    override fun getView(): View {
        return nativeView
    }

    override fun dispose() {
    }
}