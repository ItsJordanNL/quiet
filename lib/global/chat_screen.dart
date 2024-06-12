import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiet_app/global/chat_model.dart';
import 'package:intl/intl.dart';
import "package:quiet_app/constants/constants.dart";


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
    return DateFormat('HH:mm').format(dateTime);
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

  bool isNewDay(Timestamp currentTimestamp, Timestamp? previousTimestamp) {
    if (previousTimestamp == null) return true;
    final currentDate = currentTimestamp.toDate();
    final previousDate = previousTimestamp.toDate();
    return currentDate.day != previousDate.day ||
        currentDate.month != previousDate.month ||
        currentDate.year != previousDate.year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat met ${widget.receiverName}'),
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
                    final previousMessage = index + 1 < messages.length
                        ? messages[index + 1]
                        : null;
                    final isMe = message.sender == _currentUser!.uid;
                    final senderName =
                        _userNames[message.sender] ?? message.sender;
                    final showDate =
                        isNewDay(message.timestamp, previousMessage?.timestamp);

                    return Column(
                      children: [
                        if (showDate)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat('dd MMM yyyy')
                                    .format(message.timestamp.toDate()),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        Align(
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.8,
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? primary
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        senderName,
                                        style: TextStyle(
                                          color: isMe
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            10), // Space between name and time
                                    Text(
                                      formatTimestamp(message.timestamp),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color:
                                            isMe ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  message.content,
                                  style: TextStyle(
                                    color: isMe ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'Typ een bericht...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.send, color: Colors.blueAccent),
                          onPressed: _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
