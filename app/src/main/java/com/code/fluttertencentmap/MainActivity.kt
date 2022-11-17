package com.code.fluttertencentmap

import allIsGranted
import android.Manifest
import android.content.ComponentCallbacks
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.code.fluttertencentmap.flutter.NativeViewActivity
import com.tbruyelle.rxpermissions3.RxPermissions
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        if (hasPermissions()) {
            startActivityForResult(Intent(this, NativeViewActivity::class.java), 0)
        } else {
            RxPermissions(this).request(
                    Manifest.permission.READ_PHONE_STATE,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE

            ).subscribe {
                if(hasPermissions()){
                    startActivityForResult(Intent(this, NativeViewActivity::class.java), 0)
                }else{
                    finish()
                }
            }
        }
    }
    private fun hasPermissions():Boolean{
        return RxPermissions(this).allIsGranted(mutableListOf<String>().apply {
            add(Manifest.permission.READ_PHONE_STATE)
            add(Manifest.permission.WRITE_EXTERNAL_STORAGE)
        })
    }
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        finish()
    }

}