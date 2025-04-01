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
            onPressed: websocket.status == WebSocketStatus.connected
                ? websocket.disconnect
                : websocket.connect,
            child: websocket.status == WebSocketStatus.connecting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(websocket.status == WebSocketStatus.connected
                    ? "Disconnect"
                    : "Connect"),
          ),
          if (websocket.status == WebSocketStatus.failed)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(websocket.errorMessage,
                  style: const TextStyle(color: Colors.red)),
            ),
          if (websocket.status == WebSocketStatus.connected)
            const InteractionScreen(),
        ],
      ),
    );
  }
}
