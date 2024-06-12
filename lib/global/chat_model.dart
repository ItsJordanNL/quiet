import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String content;
  final String sender;
  final String receiver;
  final Timestamp timestamp;

  ChatMessage({required this.content, required this.sender, required this.receiver, required this.timestamp});

  factory ChatMessage.fromMap(Map<String, dynamic> data) {
    return ChatMessage(
      content: data['content'] ?? '',
      sender: data['sender'] ?? '',
      receiver: data['receiver'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}

