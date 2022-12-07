import 'package:flutter/material.dart';
import 'package:flutter_tencent_map/TextView.dart';
import 'package:flutter_tencent_map/socket/WebsocketFactory.dart';
import 'package:flutter_tencent_map/test_page_1.dart';
import 'package:flutter_tencent_map/web_socket_page.dart';

import 'common/RoutePath.dart';
import 'native_view_factory.dart';
import 'test_page_0.dart';

// void main() => runApp(const MyApp());
void main()  {
  WebSocketFactory.instance.initWebSocket();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const WebSocketPage(),
        RoutePath.tencent_map: (context) => const NativeView(1),
        RoutePath.test_page_0: (context) => const TestPage0(),
        RoutePath.test_page_1: (context) => const TestPage1(),
        RoutePath.websocket_page: (context) => const WebSocketPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextView(
              text: "balance",
              marginTop: 50,
              paddingLeft: 10,
              paddingRight: 10,
              paddingTop: 20,
              paddingBottom: 20,
              background: Colors.blue,
              textColor: Colors.red,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
