// Chat Message Widget
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final Map<String, dynamic> message;

  const ChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isUser = message["role"] == "user";
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isUser ? "You" : "Assistant",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(message["content"]),
        ],
      ),
    );
  }
}
