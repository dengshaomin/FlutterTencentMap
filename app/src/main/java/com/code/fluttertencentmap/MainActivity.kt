package com.code.fluttertencentmap

import allIsGranted
import android.Manifest
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.tbruyelle.rxpermissions3.RxPermissions
import com.tencent.tencentmap.mapsdk.maps.model.MarkerOptions
import kotlinx.android.synthetic.main.activity_main.*


class MainActivity : AppCompatActivity() {
    private var lastLevel = 0f
    private var pointDistance: Double = 0.0
    private var leftMarker: MarkerOptions? = null
    private var rightMarker: MarkerOptions? = null
    private var mapScreenWith: Int = 0
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
//        startActivity(
//            FlutterActivity.withNewEngine().initialRoute("webf_page").build(this@MainActivity))
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
    }

    private fun hasPermissions(): Boolean {
        return RxPermissions(this).allIsGranted(mutableListOf<String>().apply {
            add(Manifest.permission.READ_PHONE_STATE)
            add(Manifest.permission.WRITE_EXTERNAL_STORAGE)
        })
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
//        finish()
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