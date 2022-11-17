import 'package:flutter/material.dart';
import 'package:flutter_tencent_map/common/RoutePath.dart';

// Uncomment lines 3 and 6 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

class TestPage0 extends StatelessWidget {
  const TestPage0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test page 0"),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.yellow,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutePath.test_page_1);
                },
                child: const Text(
                  'open page 1',
                ),
              )),
        ),
      ),
    );
  }
}
