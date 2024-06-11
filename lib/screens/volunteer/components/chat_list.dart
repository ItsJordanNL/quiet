import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'chat_screen.dart'; // Import the ChatScreen

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  UserListScreenState createState() => UserListScreenState();
}

enum SortMode { recent, status, alphabetical }

class UserListScreenState extends State<UserListScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  SortMode _selectedSortMode = SortMode.recent;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  String formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final formattedDate =
        DateFormat('HH:mm @ dd-MM').format(dateTime);
    return formattedDate;
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      case 3:
      default:
        return Colors.grey;
    }
  }

  Stream<Map<String, dynamic>> getLastMessageDetails() {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('participants', arrayContains: _currentUser!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      final Map<String, Map<String, dynamic>> userLastMessageDetails = {};
      for (var message in snapshot.docs) {
        final participants = List<String>.from(message['participants']);
        final timestamp = message['timestamp'] as Timestamp;
        final content = message['content'] as String;
        for (var userId in participants) {
          if (userId != _currentUser!.uid) {
            if (!userLastMessageDetails.containsKey(userId) ||
                userLastMessageDetails[userId]!['timestamp']!
                        .compareTo(timestamp) <
                    0) {
              userLastMessageDetails[userId] = {
                'timestamp': timestamp,
                'content': content
              };
            }
          }
        }
      }
      return userLastMessageDetails;
    });
  }

  void _sortUsers(List<DocumentSnapshot> users,
      Map<String, dynamic> userLastMessageDetails) {
    switch (_selectedSortMode) {
      case SortMode.recent:
        users.sort((a, b) {
          final timeA = userLastMessageDetails[a.id]?['timestamp'];
          final timeB = userLastMessageDetails[b.id]?['timestamp'];
          if (timeA == null && timeB == null) return 0;
          if (timeA == null) return 1;
          if (timeB == null) return -1;
          return timeB.compareTo(timeA);
        });
        break;
      case SortMode.status:
        users.sort((a, b) {
          final statusA = a['status'] as int;
          final statusB = b['status'] as int;
          return statusA.compareTo(statusB);
        });
        break;
      case SortMode.alphabetical:
        users.sort((a, b) {
          final nameA = a['naam'] as String;
          final nameB = b['naam'] as String;
          return nameA.compareTo(nameB);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gebruikers'),
        actions: [
          PopupMenuButton<SortMode>(
            onSelected: (SortMode result) {
              setState(() {
                _selectedSortMode = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortMode>>[
              const PopupMenuItem<SortMode>(
                value: SortMode.recent,
                child: Text('Recent'),
              ),
              const PopupMenuItem<SortMode>(
                value: SortMode.status,
                child: Text('Status'),
              ),
              const PopupMenuItem<SortMode>(
                value: SortMode.alphabetical,
                child: Text('Alfabetisch'),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Zoek gebruikers...',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: getLastMessageDetails(),
        builder: (context, messageDetailsSnapshot) {
          if (messageDetailsSnapshot.hasError) {
            return Center(
                child: Text('Error: ${messageDetailsSnapshot.error}'));
          }
          if (!messageDetailsSnapshot.hasData ||
              messageDetailsSnapshot.connectionState ==
                  ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final userLastMessageDetails = messageDetailsSnapshot.data!;

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, userSnapshot) {
              if (userSnapshot.hasError) {
                return Center(child: Text('Error: ${userSnapshot.error}'));
              }
              if (!userSnapshot.hasData ||
                  userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              var users = userSnapshot.data!.docs
                  .where((doc) => doc.id != _currentUser!.uid)
                  .toList();

              if (_searchQuery.isNotEmpty) {
                users = users.where((user) {
                  final userName = user['naam'].toString().toLowerCase();
                  return userName.contains(_searchQuery);
                }).toList();
              }

              _sortUsers(users, userLastMessageDetails);

              return ListView.separated(
                itemCount: users.length,
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1), // Add divider between items
                itemBuilder: (context, index) {
                  final user = users[index];
                  final userName = user['naam'];
                  final userId = user.id;
                  final userStatus = user['status'] as int;
                  final lastMessageDetails = userLastMessageDetails[userId];
                  final lastMessageTime = lastMessageDetails != null
                      ? formatTimestamp(lastMessageDetails['timestamp'])
                      : null;
                  final lastMessageContent = lastMessageDetails != null
                      ? lastMessageDetails['content']
                      : null;

                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: getStatusColor(userStatus),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                                width: 8), // Space between dot and text
                            Text(userName, style: const TextStyle(fontWeight: FontWeight.bold,)),
                          ],
                        ),
                        if (lastMessageTime != null)
                          Text(
                            lastMessageTime,
                            style: const TextStyle(
                                fontSize: 14), // Adjust the font size as needed
                          ),
                      ],
                    ),
                    subtitle: Text(
                      lastMessageContent ?? 'Nog geen berichten...',
                      style: const TextStyle(
                          fontSize: 16), // Adjust the font size as needed
                      maxLines: 1, // Limit to one line
                      overflow: TextOverflow
                          .ellipsis, // Show ellipsis if the text overflows
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            receiverId: user.id,
                            receiverName: userName,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
