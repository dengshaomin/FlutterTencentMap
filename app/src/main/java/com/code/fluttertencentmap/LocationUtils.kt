package com.code.fluttertencentmap

import allIsGranted
import android.Manifest.permission
import android.os.Build
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import com.tbruyelle.rxpermissions3.RxPermissions

class LocationUtils {

  companion object {
    val instance: LocationUtils by lazy(mode = LazyThreadSafetyMode.SYNCHRONIZED) {
      LocationUtils()
    }

    val permissions = mutableListOf<String>(
        permission.ACCESS_COARSE_LOCATION,
        permission.ACCESS_FINE_LOCATION,
//      permission.READ_PHONE_STATE,
//      permission.WRITE_EXTERNAL_STORAGE
    )
    val permissionsForQ = mutableListOf<String>(
        permission.ACCESS_COARSE_LOCATION,
        permission.ACCESS_FINE_LOCATION,
//        permission.ACCESS_BACKGROUND_LOCATION,  //target为Q时，动态请求后台定位权限；如果权限使用期间允许 该权限会失败，暂时注释
//      permission.READ_PHONE_STATE,
//      permission.WRITE_EXTERNAL_STORAGE
    )


    fun hasLocationPermissions(fragmentActivity: FragmentActivity): Boolean {
      return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) RxPermissions(
          fragmentActivity
      ).allIsGranted(
          permissionsForQ
      ) else RxPermissions(fragmentActivity).allIsGranted(permissions)
    }

    fun hasLocationPermissions(fragmentActivity: Fragment): Boolean {
      return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) RxPermissions(
          fragmentActivity
      ).allIsGranted(
          permissionsForQ
      ) else RxPermissions(fragmentActivity).allIsGranted(permissions)
    }
  }

  init {
  }
}