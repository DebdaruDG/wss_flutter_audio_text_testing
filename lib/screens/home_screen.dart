// Home Screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/websocket_provider.dart';
import 'interaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final websocket = Provider.of<WebSocketProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("WebSocket Chat")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: websocket.isConnected
                ? websocket.disconnect
                : websocket.connect,
            child: Text(websocket.isConnected ? "Disconnect" : "Connect"),
          ),
          if (websocket.isConnected) const InteractionScreen(),
        ],
      ),
    );
  }
}
