import 'package:flutter/material.dart';
import 'chat-list.dart'; // Import the chat model
import 'package:quiet_app/constants/constants.dart';

// Message model
class Message {
  final String text;
  final bool isSentByUser;

  Message({required this.text, required this.isSentByUser});
}

class ChatDetailPage extends StatefulWidget {
  final Chat chat;
  final Function(Chat, String) updateStatus; // Add this line

  ChatDetailPage({required this.chat, required this.updateStatus}); // Update constructor

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  late String status;

  @override
  void initState() {
    super.initState();
    _messages.add(Message(text: widget.chat.lastMessage, isSentByUser: false));
    status = widget.chat.status;
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(Message(text: _controller.text, isSentByUser: true));
        _controller.clear();
      });
    }
  }

  void _changeStatus(String newStatus) {
    setState(() {
      status = newStatus;
      widget.updateStatus(widget.chat, newStatus); // Call the callback function
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chat.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: primary,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert), color: Colors.white,
            onSelected: _changeStatus,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'geholpen',
                child: Text('Geholpen'),
              ),
              const PopupMenuItem<String>(
                value: 'inproces',
                child: Text('In proces'),
              ),
              const PopupMenuItem<String>(
                value: 'heefthulpnodig',
                child: Text('Heeft hulp nodig'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: message.isSentByUser ? primary : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: message.isSentByUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Begin met typen...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: primary,
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
