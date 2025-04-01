// WebSocket Provider
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketProvider with ChangeNotifier {
  WebSocketChannel? _channel;
  bool _isConnected = false;
  final List<Map<String, dynamic>> _messages = [];

  bool get isConnected => _isConnected;
  List<Map<String, dynamic>> get messages => _messages;

  void connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse(
        'wss://pu6niet7nl.execute-api.ap-south-1.amazonaws.com/production/',
      ),
    );
    _isConnected = true;
    _channel!.stream.listen(
      (message) {
        _messages.add({"role": "assistant", "content": message});
        notifyListeners();
      },
      onDone: () {
        _isConnected = false;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  void disconnect() {
    _channel?.sink.close();
    _isConnected = false;
    notifyListeners();
  }

  void sendMessage(String message) {
    if (_isConnected) {
      _messages.add({"role": "user", "content": message});
      _channel!.sink.add(
        jsonEncode({"action": "chatbotSocket", "body": message}),
      );
      notifyListeners();
    }
  }
}
