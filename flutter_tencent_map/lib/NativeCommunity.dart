import 'dart:collection';

import 'package:flutter/services.dart';

class NativeCommunity {
  static final NativeCommunity _instance = NativeCommunity._internal();
  NativeCommunity._internal();
  static NativeCommunity getInstance() {
    return _instance;
  }

  Map<String,dynamic> params = HashMap();
  final MethodChannel _flutterNativeChannel = MethodChannel("flutter_native_channel");

  void init() {
    _getCommonParams();
  }

  void _getCommonParams()  async {
    try {
      Map<String,dynamic> map = await  _flutterNativeChannel.invokeMethod("getCommonParams") as Map<String, dynamic>;
      if(map.isNotEmpty){
        params.clear();
        params.addAll(map);
      }

    } on PlatformException catch (e) {
      print("balance: ${e.message}");
    }
  }
}
