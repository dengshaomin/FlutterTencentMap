import 'package:flutter/material.dart';
import 'package:flutter_tencent_map/socket/SocketListener.dart';
import 'package:flutter_tencent_map/socket/WebsocketFactory.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketPage extends StatelessWidget {
  const WebSocketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("WebSocketClient")),
        body: const WebSocketStatefulWidget());
  }
}

class WebSocketStatefulWidget extends StatefulWidget {
  const WebSocketStatefulWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WebSocketStatefulState();
  }
}

class WebSocketStatefulState extends State<WebSocketStatefulWidget> {
  TextEditingController inputControl = TextEditingController();
  IOWebSocketChannel? channel;
  var connected = false;
  var working = false;
  String serverUrl = "";
  String serverResponse = "";

  @override
  void initState() {
    super.initState();
  }

  void sendMsg() {
    WebSocketFactory.instance.sendMessage("message");
  }

  SocketListener socketListener = SocketListener(
      () => {debugPrint("callback: connect")},
      () => {debugPrint("callback: disconnect")},
      (String data) => {debugPrint("callback：$data")});

  @override
  Widget build(BuildContext context) {
    WebSocketFactory.instance.registerListener(socketListener);

    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            // initialValue:
            //     "wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self",
            decoration: const InputDecoration(
              labelText: "输入要发送的消息",
            ),
            controller: inputControl,
          ),
          GestureDetector(
              onTap: () => sendMsg(),
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                color: Colors.tealAccent,
                child: const Center(
                  child: Text("发送"),
                ),
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    WebSocketFactory.instance.unRegisterListener(socketListener);
    super.dispose();
  }
}
