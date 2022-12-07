import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tencent_map/socket/SocketListener.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// WebSocket地址
const String _SOCKET_URL =
    'wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self';

/// WebSocket状态
enum SocketStatus {
  SocketStatusConnected, // 已连接
  SocketStatusFailed, // 失败
  SocketStatusClosed, // 连接关闭
}

class WebSocketFactory {
  WebSocketFactory._privateConstructor();

  static final WebSocketFactory _instance =
      WebSocketFactory._privateConstructor();

  static WebSocketFactory get instance {
    return _instance;
  }

  IOWebSocketChannel? _webSocket; // WebSocket
  SocketStatus _socketStatus = SocketStatus.SocketStatusClosed; // socket状态
  Timer? _heartBeat; // 心跳定时器
  final int _heartTimes = 3000; // 心跳间隔(毫秒)
  final int _reconnectCount = 60; // 重连次数，默认60次
  int _reconnectTimes = 0; // 重连计数器
  Timer? _reconnectTimer; // 重连定时器
  // Function? onError; // 连接错误回调
  // Function? onOpen; // 连接开启回调
  // Function? onMessage; // 接收消息回调
  List<SocketListener> _listeners = [];

  /// 初始化WebSocket
  void initWebSocket() async {
    _openSocket();
  }

  void registerListener(SocketListener listener) {
    if (_listeners.contains(listener)) {
      return;
    }
    _listeners.add(listener);
  }

  void unRegisterListener(SocketListener listener) {
    _listeners.remove(listener);
  }

  /// 开启WebSocket连接
  void _openSocket() {
    if (_socketStatus == SocketStatus.SocketStatusConnected) {
      return;
    }
    // closeSocket();
    _webSocket = IOWebSocketChannel.connect(_SOCKET_URL);
    debugPrint('WebSocket连接成功: $_SOCKET_URL');
    // 连接成功，返回WebSocket实例
    _socketStatus = SocketStatus.SocketStatusConnected;
    // 连接成功，重置重连计数器
    _reconnectTimes = 0;
    if (_reconnectTimer != null) {
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
    }
    for (int i = 0; i < _listeners.length; i++) {
      _listeners[i].onConnected;
    }
    // 接收消息
    _webSocket?.stream.listen((data) => webSocketOnMessage(data),
        onError: webSocketOnError, onDone: webSocketOnDone);
  }

  /// WebSocket接收消息回调
  webSocketOnMessage(data) {
    debugPrint("收到消息：$data");
    for (int i = 0; i < _listeners.length; i++) {
      _listeners[i].onMessage(data);
    }
  }

  /// WebSocket关闭连接回调
  webSocketOnDone() {
    for (int i = 0; i < _listeners.length; i++) {
      _listeners[i].onDisConnected;
    }
    reconnect();
  }

  /// WebSocket连接错误回调
  webSocketOnError(e) {
    WebSocketChannelException ex = e;
    _socketStatus = SocketStatus.SocketStatusFailed;
    for (int i = 0; i < _listeners.length; i++) {
      _listeners[i].onDisConnected;
    }
    closeSocket();
  }

  /// 初始化心跳
  void _initHeartBeat() {
    _destroyHeartBeat();
    _heartBeat = Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
      _sentHeart();
    });
  }

  /// 心跳
  void _sentHeart() {
    sendMessage('{"module": "HEART_CHECK", "message": "请求心跳"}');
  }

  /// 销毁心跳
  void _destroyHeartBeat() {
    if (_heartBeat != null) {
      _heartBeat?.cancel();
      _heartBeat = null;
    }
  }

  /// 关闭WebSocket
  void closeSocket() {
    if (_webSocket != null) {
      debugPrint('WebSocket连接关闭');
      _webSocket?.sink.close();
      _destroyHeartBeat();
      _socketStatus = SocketStatus.SocketStatusClosed;
    }
  }

  /// 发送WebSocket消息
  void sendMessage(message) {
    if (_webSocket != null) {
      switch (_socketStatus) {
        case SocketStatus.SocketStatusConnected:
          debugPrint('发送中：' + message);
          _webSocket?.sink.add(message);
          break;
        case SocketStatus.SocketStatusClosed:
          debugPrint('连接已关闭');
          break;
        case SocketStatus.SocketStatusFailed:
          debugPrint('发送失败');
          break;
        default:
          break;
      }
    }
  }

  /// 重连机制
  void reconnect() {
    if (_reconnectTimes < _reconnectCount) {
      _reconnectTimes++;
      _reconnectTimer =
          Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
        _openSocket();
      });
    } else {
      if (_reconnectTimer != null) {
        debugPrint('重连次数超过最大次数');
        _reconnectTimer?.cancel();
        _reconnectTimer = null;
      }
      return;
    }
  }
}
