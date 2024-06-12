import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiet_app/global/chat_model.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatScreen(
      {super.key, required this.receiverId, required this.receiverName});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  Map<String, String> _userNames = {};

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    _fetchUserNames();
  }

  String formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final centralEuropeanTime =
        dateTime.add(const Duration(hours: 2)); // Adjust for CET
    final formattedDate =
        DateFormat('HH:mm @ dd-MM').format(centralEuropeanTime);
    return formattedDate;
  }

  Future<void> _fetchUserNames() async {
    QuerySnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    Map<String, String> names = {};
    for (var doc in userSnapshot.docs) {
      names[doc.id] = doc['naam'];
    }
    setState(() {
      _userNames = names;
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty && _currentUser != null) {
      String combinedId = _getCombinedId(_currentUser!.uid, widget.receiverId);

      FirebaseFirestore.instance.collection('messages').add({
        'content': _controller.text,
        'sender': _currentUser!.uid,
        'receiver': widget.receiverId,
        'participants': [widget.receiverId, _currentUser!.uid],
        'combinedId': combinedId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
    }
  }

  String _getCombinedId(String uid1, String uid2) {
    return uid1.hashCode <= uid2.hashCode ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.receiverName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .where('combinedId',
                      isEqualTo:
                          _getCombinedId(_currentUser!.uid, widget.receiverId))
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  if (kDebugMode) {
                    print('Firestore Error: ${snapshot.error}');
                  }
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!.docs
                    .map((doc) =>
                        ChatMessage.fromMap(doc.data() as Map<String, dynamic>))
                    .toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final senderName =
                        _userNames[message.sender] ?? message.sender;
                    return ListTile(
                      title: Text(senderName),
                      subtitle: Text(message.content),
                      trailing: Text(
                        message.timestamp.toDate().toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(labelText: 'Typ een bericht...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
