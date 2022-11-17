import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class NativeView extends StatelessWidget {
  static const nativeCommunityChannel = MethodChannel("METHOD_EVENT_CHANNEL");
  final int viewId;

  const NativeView(this.viewId, {Key? key}) : super(key: key);

  Future<dynamic> nativeCallMethod(MethodCall call) async {
    switch (call.method) {
      case "GET_FLUTTER_RESOURCE":
        return "flutter data";
      default:
        return "can't find flutter method";
    }
  }

  Future<void> getBatteryLevel() async {
    // setState(() {
    //   batteryLevel = 'fetching...';
    // });
    try {
      final String result = await nativeCommunityChannel.invokeMethod(
          'GET_NATIVE_RESOURCE', null);
      print(result);
    } on PlatformException catch (e) {
      log(e.details);
    }
  }

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    nativeCommunityChannel.setMethodCallHandler(nativeCallMethod);
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PlatformViewLink(
              viewType: viewType,
              surfaceFactory: (context, controller) {
                return AndroidViewSurface(
                  controller: controller as AndroidViewController,
                  gestureRecognizers: const <
                      Factory<OneSequenceGestureRecognizer>>{},
                  hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                );
              },
              onCreatePlatformView: (params) {
                return PlatformViewsService.initSurfaceAndroidView(
                  id: viewId,
                  viewType: viewType,
                  layoutDirection: TextDirection.ltr,
                  creationParams: creationParams,
                  creationParamsCodec: const StandardMessageCodec(),
                  onFocus: () {
                    params.onFocusChanged(true);
                  },
                )
                  ..addOnPlatformViewCreatedListener(
                      params.onPlatformViewCreated)
                  ..create();
              },
            ),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: getBatteryLevel,
                  child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.yellow,
                child: const Text(
                  'call native method',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )))
        ],
      ),
    );
    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (params) {
        return PlatformViewsService.initSurfaceAndroidView(
          id: viewId,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onFocus: () {
            params.onFocusChanged(true);
          },
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
    );
  }

  Widget buildStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.black45,
          ),
          child: const Text(
            'Mia B',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
