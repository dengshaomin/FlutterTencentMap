package com.code.fluttertencentmap.flutter

import android.content.Context
import androidx.lifecycle.Lifecycle
import com.code.fluttertencentmap.flutter.nativeview.NativeTencentView
import com.code.fluttertencentmap.flutter.nativeview.NativeViewTest
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeViewFactory(val lifecycleProvider: LifecycleProvider) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    companion object {
        const val NativeViewType = "<platform-view-type>"
        var VIEW_ID_TEST = 0
        var VIEW_ID_TENCENT_MAP = 1
    }

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        val view = when (viewId) {
            VIEW_ID_TENCENT_MAP -> NativeTencentView(lifecycleProvider,context,)
            else -> NativeTencentView(lifecycleProvider,context)
        }
        return NativeViewContainer(view)
    }
}