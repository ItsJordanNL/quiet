import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiet_app/screens/volunteer/components/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  ChatScreen({required this.receiverId, required this.receiverName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

  Future<void> _fetchUserNames() async {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').get();
    Map<String, String> names = {};
    userSnapshot.docs.forEach((doc) {
      names[doc.id] = doc['naam'];
    });
    setState(() {
      _userNames = names;
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty && _currentUser != null) {
      FirebaseFirestore.instance.collection('messages').add({
        'content': _controller.text,
        'sender': _currentUser!.uid,
        'receiver': widget.receiverId,
        'participants': [widget.receiverId, _currentUser!.uid],
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
    }
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
                  .where('participants', arrayContainsAny: [_currentUser?.uid ?? '', widget.receiverId])
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('Firestore Error: ${snapshot.error}');
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!.docs
                    .map((doc) => ChatMessage.fromMap(doc.data() as Map<String, dynamic>))
                    .toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final senderName = _userNames[message.sender] ?? message.sender;
                    return ListTile(
                      title: Text(senderName),
                      subtitle: Text(message.content),
                      trailing: Text(
                        message.timestamp.toDate().toString(),
                        style: TextStyle(fontSize: 10),
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
                    decoration: InputDecoration(labelText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
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
