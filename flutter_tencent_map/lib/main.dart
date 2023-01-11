import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tencent_map/NativeCommunity.dart';
import 'package:flutter_tencent_map/TextView.dart';
import 'package:flutter_tencent_map/test_page_1.dart';
import 'package:flutter_tencent_map/webf_page.dart';

import 'common/RoutePath.dart';
import 'test_page_0.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NativeCommunity.getInstance().init();
  runApp(const MyApp2());
}
// void main() {
//   CustomFlutterBinding();
//   runApp(const MyApp());
// }

// class CustomFlutterBinding extends WidgetsFlutterBinding
//     with BoostFlutterBinding {}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   Map<String, FlutterBoostRouteFactory> routerMap = {
//     RoutePath.test_page_0: (settings, uniqueId) {
//       return CupertinoPageRoute(
//           settings: settings,
//           builder: (_) {
//             Map<String, dynamic> map =
//                 settings.arguments as Map<String, dynamic>;
//             print("balance:params:${map}");
//             return const TestPage0();
//           });
//     },
//     RoutePath.test_page_1: (settings, uniqueId) {
//       return CupertinoPageRoute(
//           settings: settings,
//           builder: (_) {
//             Map<String, dynamic> map =
//                 settings.arguments as Map<String, dynamic>;
//             print("balance:params:${map}");
//             String data = map['data'] as String;
//             return const TestPage1();
//           });
//     },
//   };
//
//   Route<dynamic>? routeFactory(RouteSettings settings, String? uniqueId) {
//     FlutterBoostRouteFactory? func = routerMap[settings.name!];
//     if (func == null) {
//       return null;
//     }
//     return func(settings, uniqueId);
//   }
//
//   Widget appBuilder(Widget home) {
//     return MaterialApp(
//       home: home,
//       debugShowCheckedModeBanner: true,
//
//       ///必须加上builder参数，否则showDialog等会出问题
//       builder: (_, __) {
//         return home;
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FlutterBoostApp(
//       routeFactory,
//       appBuilder: appBuilder,
//     );
//   }
// }

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routes: {
      //   '/': (context) => const WebFPage(),
      //   RoutePath.tencent_map: (context) => const NativeView(1),
      //   RoutePath.test_page_0: (context) => const TestPage0(),
      //   RoutePath.test_page_1: (context) => const TestPage1(),
      //   RoutePath.websocket_page: (context) => const WebSocketPage(),
      //   RoutePath.webf_page:(context) => const WebFPage(),
      // },
      onGenerateRoute: (setting) {
        assert(setting.name?.isNotEmpty == true);
        Uri uri = Uri.parse(setting.name ?? "");
        String path = uri.path;
        Object? argument = uri.queryParameters;
        print("balance:${path}:${argument}:${NativeCommunity.getInstance().params}");
        switch (path) {
          case RoutePath.test_page_0:
            MaterialPageRoute(builder: (context) => const TestPage0());
            break;
          case RoutePath.test_page_1:
            MaterialPageRoute(builder: (context) => const TestPage1());
            break;
        }
        return MaterialPageRoute(builder: (context) => const WebFPage());
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
