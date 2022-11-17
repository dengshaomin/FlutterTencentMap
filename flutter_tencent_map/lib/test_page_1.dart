import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tencent_map/common/RoutePath.dart';

// Uncomment lines 3 and 6 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

class TestPage1 extends StatelessWidget {
  static const nativeCommunityChannel = MethodChannel("METHOD_EVENT_CHANNEL");

  Future<dynamic> nativeCallMethod(MethodCall call) async {
    switch (call.method) {
      case "GET_FLUTTER_RESOURCE":
        return "flutter data";
      default:
        return "can't find flutter method";
    }
  }

  const TestPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test page 1"),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
            child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                color: Colors.yellow,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePath.test_page_0);
                  },
                  child: const Text(
                    'open page 0',
                  ),
                )),
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                color: Colors.yellow,
                child: GestureDetector(
                  onTap: () {
                    nativeCommunityChannel.invokeMethod(
                        "OPEN_NATIVE_PAGE", "NATIVE_PAGE_ACTIVITY");
                  },
                  child: const Text(
                    'open native page',
                  ),
                )),
          ],
        )),
      ),
    );
  }
}
