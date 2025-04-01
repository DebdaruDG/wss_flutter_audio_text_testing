// WebSocket Provider
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum WebSocketStatus {
  disconnected,
  connecting,
  connected,
  failed,
}

class WebSocketProvider with ChangeNotifier {
  WebSocketChannel? _channel;
  WebSocketStatus _status = WebSocketStatus.disconnected;
  String _errorMessage = "";
  final List<Map<String, dynamic>> _messages = [];

  WebSocketStatus get status => _status;
  String get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get messages => _messages;

  void connect() {
    _status = WebSocketStatus.connecting;
    _errorMessage = "";
    notifyListeners();

    try {
      _channel = WebSocketChannel.connect(
        Uri.parse(
            'wss://pu6niet7nl.execute-api.ap-south-1.amazonaws.com/production/'),
      );
      _status = WebSocketStatus.connected;
      _channel!.stream.listen((message) {
        _messages.add({"role": "assistant", "content": message});
        notifyListeners();
      }, onDone: () {
        _status = WebSocketStatus.disconnected;
        notifyListeners();
      }, onError: (error) {
        _status = WebSocketStatus.failed;
        _errorMessage = "Connection failed: ${error.toString()}";
        notifyListeners();
      });
    } catch (e) {
      _status = WebSocketStatus.failed;
      _errorMessage = "Internal Server Error (500) - Unable to connect";
      notifyListeners();
    }
  }

  void disconnect() {
    _channel?.sink.close();
    _status = WebSocketStatus.disconnected;
    notifyListeners();
  }

  void sendMessage(String message) {
    if (_status == WebSocketStatus.connected) {
      _messages.add({"role": "user", "content": message});
      _channel!.sink
          .add(jsonEncode({"action": "chatbotSocket", "body": message}));
      notifyListeners();
    }
  }
}
