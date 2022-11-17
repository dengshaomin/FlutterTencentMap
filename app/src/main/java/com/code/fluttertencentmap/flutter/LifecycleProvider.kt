package com.code.fluttertencentmap.flutter

import androidx.lifecycle.Lifecycle

interface LifecycleProvider {
    fun getLifecycle(): Lifecycle?
}