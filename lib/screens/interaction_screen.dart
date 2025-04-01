// Interaction Screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/websocket_provider.dart';

class InteractionScreen extends StatefulWidget {
  const InteractionScreen({super.key});

  @override
  _InteractionScreenState createState() => _InteractionScreenState();
}

class _InteractionScreenState extends State<InteractionScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final websocket = Provider.of<WebSocketProvider>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {}, child: const Text("Text to Audio")),
            ElevatedButton(onPressed: () {}, child: const Text("Text to Text")),
            ElevatedButton(
                onPressed: () {}, child: const Text("Audio to Text")),
            ElevatedButton(
                onPressed: () {}, child: const Text("Audio to Audio")),
          ],
        ),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: "Enter message"),
        ),
        ElevatedButton(
          onPressed: () => websocket.sendMessage(_controller.text),
          child: const Text("Send"),
        ),
      ],
    );
  }
}
