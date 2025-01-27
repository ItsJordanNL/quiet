import "package:flutter/material.dart";
import "package:quiet_app/global/chat_list.dart";

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserListScreen(),
    );
  }
}
