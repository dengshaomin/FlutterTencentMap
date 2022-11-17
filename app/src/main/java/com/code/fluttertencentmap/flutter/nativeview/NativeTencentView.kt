package com.code.fluttertencentmap.flutter.nativeview

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.widget.FrameLayout
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import com.code.fluttertencentmap.R
import com.code.fluttertencentmap.flutter.LifecycleProvider
import kotlinx.android.synthetic.main.view_native_tencent.view.*

class NativeTencentView @JvmOverloads constructor(
    lifecycleProvider: LifecycleProvider,
    context: Context, attrs: AttributeSet? = null
) : FrameLayout(context, attrs),DefaultLifecycleObserver {
    init {
        LayoutInflater.from(context).inflate(R.layout.view_native_tencent, this)
        initView()
        lifecycleProvider.getLifecycle()?.addObserver(this)
    }

    override fun onStart(owner: LifecycleOwner) {
        super.onStart(owner)
        tencent_map?.onStart()
    }

    override fun onResume(owner: LifecycleOwner) {
        super.onResume(owner)
        tencent_map?.onResume()
    }

    override fun onPause(owner: LifecycleOwner) {
        super.onPause(owner)
        tencent_map?.onPause()
    }

    override fun onDestroy(owner: LifecycleOwner) {
        super.onDestroy(owner)
        tencent_map?.onDestroy()
    }
    private fun initView() {
        tencent_map.apply {
            map.apply {
                setOnMapLoadedCallback {
                }
            }
        }
    }
}
