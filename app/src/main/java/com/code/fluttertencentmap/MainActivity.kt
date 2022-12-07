package com.code.fluttertencentmap

import allIsGranted
import android.Manifest
import android.content.Intent
import android.os.Bundle
import android.os.IBinder
import android.util.Log
import android.view.Menu
import androidx.appcompat.app.AppCompatActivity
import com.blankj.utilcode.util.ClipboardUtils
import com.blankj.utilcode.util.SizeUtils
import com.blankj.utilcode.util.ViewUtils
import com.code.fluttertencentmap.flutter.NativeViewActivity
import com.tbruyelle.rxpermissions3.RxPermissions
import com.tencent.map.geolocation.TencentLocationUtils
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import com.tencent.tencentmap.mapsdk.maps.model.*
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class MainActivity : AppCompatActivity() {
    private var lastLevel = 0f
    private var pointDistance:Double = 0.0
    private var leftMarker:MarkerOptions?=null
    private var rightMarker:MarkerOptions?=null
    private var mapScreenWith :Int = 0
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        Log.e("balance", ClipboardUtils.getText().toString())
//        if (hasPermissions()) {
//            startActivityForResult(Intent(this, NativeViewActivity::class.java), 0)
//        } else {
//            RxPermissions(this).request(
//                    Manifest.permission.READ_PHONE_STATE,
//                    Manifest.permission.WRITE_EXTERNAL_STORAGE
//
//            ).subscribe {
//                if(hasPermissions()){
//                    startActivityForResult(Intent(this, NativeViewActivity::class.java), 0)
//                }else{
//                    finish()
//                }
//            }
//        }

        tencent_map.map.apply {
            setOnCameraChangeListener(object : TencentMap.OnCameraChangeListener {
                override fun onCameraChange(p0: CameraPosition?) {
                }

                override fun onCameraChangeFinished(p0: CameraPosition?) {
                    p0?.zoom?.let {
                        if(leftMarker == null || rightMarker == null){
                            return
                        }
                        if (lastLevel != it) {
                            lastLevel = it
                            val bounds = tencent_map.map.projection?.visibleRegion?.latLngBounds
                            val leftLatLng = LatLng(bounds!!.northEast.latitude, bounds.lonEast)
                            val rightLatlng = LatLng(bounds!!.northEast.latitude, bounds.lonWest)
                            val mapWithDistance = TencentLocationUtils.distanceBetween(
                                leftLatLng.latitude,
                                leftLatLng.longitude,
                                rightLatlng.latitude,
                                rightLatlng.longitude
                            )
                            val value = SizeUtils.dp2px(80f)/mapScreenWith.toFloat() * mapWithDistance
                            Log.e("balance","${mapScreenWith} -- ${mapWithDistance} -- ${value} --${it} --${pointDistance}" )
                        }
                    }
                }
            })

        }
        GlobalScope.launch {
            delay(1000)
            GlobalScope.launch(Dispatchers.Main) {
                val map = tencent_map.map
                val bounds = map.projection?.visibleRegion?.latLngBounds
                leftMarker = MarkerOptions(LatLng(bounds!!.northEast.latitude, bounds.lonEast)).icon(
                    BitmapDescriptorFactory.fromView(MarkerView(this@MainActivity))
                )
                rightMarker = MarkerOptions(LatLng(bounds!!.northEast.latitude, bounds.lonWest)).icon(
                    BitmapDescriptorFactory.fromView(MarkerView(this@MainActivity))
                )
                map.addMarker(leftMarker)
                map.addMarker(rightMarker)
                mapScreenWith = map.projection.toScreenLocation(bounds?.northEast).x
                pointDistance = TencentLocationUtils.distanceBetween(leftMarker!!.position.latitude,leftMarker!!.position.longitude,rightMarker!!.position.latitude,rightMarker!!.position.longitude)
            }
        }

    }

    private fun hasPermissions(): Boolean {
        return RxPermissions(this).allIsGranted(mutableListOf<String>().apply {
            add(Manifest.permission.READ_PHONE_STATE)
            add(Manifest.permission.WRITE_EXTERNAL_STORAGE)
        })
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        finish()
    }

    override fun onStart() {
        super.onStart()
        tencent_map.onStart()
    }

    override fun onResume() {
        super.onResume()
        tencent_map.onResume()
    }


    override fun onPause() {
        super.onPause()
        tencent_map.onPause()
    }

    override fun onStop() {
        super.onStop()
        tencent_map.stopNestedScroll()
    }

    override fun onDestroy() {
        super.onDestroy()
        tencent_map.onDestroy()
    }
}