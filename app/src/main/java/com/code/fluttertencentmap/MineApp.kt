package com.code.fluttertencentmap

import android.app.Activity
import android.app.Application
import android.os.Build
import android.os.Bundle
import androidx.constraintlayout.widget.ConstraintLayout
import com.code.fluttertencentmap.flutter.NativeViewActivity
import com.code.fluttertencentmap.flutter.NativeViewFactory
import com.code.fluttertencentmap.flutter.nativeview.NativeTencentView
import com.tencent.tencentmap.mapsdk.maps.MapView

class MineApp : Application() {
    override fun onCreate() {
        super.onCreate()
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            this.registerActivityLifecycleCallbacks(object : ActivityLifecycleCallbacks {
                override fun onActivityCreated(p0: Activity, p1: Bundle?) {

                }

                override fun onActivityStarted(p0: Activity) {
                    getTencentMapView(p0)?.onStart()
                }

                override fun onActivityResumed(p0: Activity) {
                    getTencentMapView(p0)?.onResume()
                }

                override fun onActivityPaused(p0: Activity) {
                    getTencentMapView(p0)?.onPause()
                }

                override fun onActivityStopped(p0: Activity) {
                    getTencentMapView(p0)?.onStop()
                }

                override fun onActivitySaveInstanceState(p0: Activity, p1: Bundle) {
                }

                override fun onActivityDestroyed(p0: Activity) {
                    getTencentMapView(p0)?.onDestroy()
                }
            })
        }
    }

    private fun getTencentMapView(activity: Activity): MapView? {
        return null
        return (((activity as? NativeViewActivity)?.getInternalEngine()?.platformViewsController?.getPlatformViewById(
            NativeViewFactory.VIEW_ID_TENCENT_MAP
        ) as? NativeTencentView)?.getChildAt(0) as? ConstraintLayout)?.getChildAt(0) as? MapView
    }
}