import 'package:flutter/material.dart';
import 'chat-list.dart';
import 'chat-detail.dart';
import 'time-button.dart';
import 'alphabetic-button.dart';
import 'status-button.dart';

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
        title: const Text(''),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0), // Increased horizontal padding
                  child: SortingButton(
                    sortByNewest: _sortByNewest,
                    onPressed: () {
                      setState(() {
                        _sortByNewest = !_sortByNewest;
                        _sortChats();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0), // Increased horizontal padding
                  child: AlphabeticButton(
                    chats: chats,
                    onPressed: (sortedChats) {
                      setState(() {
                        chats.clear();
                        chats.addAll(sortedChats);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0), // Increased horizontal padding
                  child: StatusButton(
                    onPressed: () {
                      setState(() {
                        _prioritizeChats();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  leading: _buildStatusIndicator(chat.status),
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
                        builder: (context) => ChatDetailPage(
                          chat: chat,
                          updateStatus: (updatedChat, newStatus) {
                            setState(() {
                              // Update the status of the chat in the list 'chats'
                              final index = chats.indexOf(chat);
                              if (index != -1) {
                                chats[index].status = newStatus;
                              }
                            });
                          },
                        ),
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

  Widget _buildStatusIndicator(String status) {
    Color color;
    switch (status) {
      case 'geholpen':
        color = Colors.green;
        break;
      case 'inproces':
        color = Colors.orange;
        break;
      case 'heefthulpnodig':
      default:
        color = Colors.red;
        break;
    }
    return CircleAvatar(
      radius: 5,
      backgroundColor: color,
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

  void _prioritizeChats() {
    chats.sort((a, b) {
      if (a.status == 'heefthulpnodig' && b.status != 'heefthulpnodig') {
        return -1;
      } else if (a.status == 'inproces' && b.status != 'heefthulpnodig' && b.status != 'inproces') {
        return -1;
      } else if (a.status != 'heefthulpnodig' && b.status == 'heefthulpnodig') {
        return 1;
      } else if (a.status != 'heefthulpnodig' && a.status != 'inproces' && b.status == 'inproces') {
        return 1;
      } else {
        return 0;
      }
    });
  }
}
