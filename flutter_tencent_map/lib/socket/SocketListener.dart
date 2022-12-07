typedef MessageCallback = void Function(String);

class SocketListener {
  Function onConnected;
  Function onDisConnected;
  final MessageCallback onMessage;
  // typedef StringToVoidFunc = void Function(String);
  SocketListener(this.onConnected, this.onDisConnected, this.onMessage);
}
