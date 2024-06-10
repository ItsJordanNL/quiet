import 'package:flutter/material.dart';
import 'chat-list.dart'; // Import the combined chat model and list
import 'chat-detail.dart'; // Import the chat detail page
import 'time-button.dart'; // Import the SortingButton widget
import 'alphabetic-button.dart'; // Import the AlphabeticButton widget

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  bool _sortByNewest = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SortingButton(
                sortByNewest: _sortByNewest,
                onPressed: () {
                  setState(() {
                    _sortByNewest = !_sortByNewest;
                    _sortChats();
                  });
                },
              ),
              AlphabeticButton(
                chats: chats,
                onPressed: (sortedChats) {
                  setState(() {
                    chats.clear();
                    chats.addAll(sortedChats);
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  title: Text(
                    chat.name,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    chat.lastMessage,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                    ),
                  ),
                  trailing: Text(
                    _formatTimestamp(chat.timestamp),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailPage(chat: chat),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    if (timestamp.day == now.day &&
        timestamp.month == now.month &&
        timestamp.year == now.year) {
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.month}/${timestamp.day}/${timestamp.year}';
    }
  }

  void _sortChats() {
    if (_sortByNewest) {
      chats.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    } else {
      chats.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    }
  }
}
