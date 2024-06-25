import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:quiet_app/constants/constants.dart';
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
    final formattedDate = DateFormat('HH:mm @ dd-MM').format(dateTime);
    return formattedDate;
  }

  Icon getStatusIcon(int status) {
    switch (status) {
      case 0:
        return const Icon(Icons.help_outline_rounded,
            color: Colors.red); // Red question mark
      case 1:
        return const Icon(Icons.support_agent_rounded,
            color: Colors.orange); // Orange group
      case 2:
        return const Icon(Icons.check_circle_outline_rounded,
            color: Colors.green); // Green check mark
      case 3:
      default:
        return const Icon(Icons.chat_outlined,
            color: Colors.grey); // Grey chat bubble
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
        automaticallyImplyLeading: false, // Hide the back button
        title: Row(
          children: [
            const Text(
              'Berichten',
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(), // This will push the PopupMenuButton to the right
            PopupMenuButton<SortMode>(
              icon: const Icon(Icons.sort_rounded, color: Colors.white),
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
        ),
        backgroundColor: primary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Zoek gebruikers...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0), // Adjust vertical padding
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<Map<String, dynamic>>(
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
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${userSnapshot.error}'));
                    }
                    if (!userSnapshot.hasData ||
                        userSnapshot.connectionState ==
                            ConnectionState.waiting) {
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
                      separatorBuilder: (context, index) => const Divider(
                          thickness: 1), // Add divider between items
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final userName = user['naam'];
                        final userId = user.id;
                        final userStatus = user['status'] as int;
                        final lastMessageDetails =
                            userLastMessageDetails[userId];
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
                                  getStatusIcon(userStatus),
                                  const SizedBox(
                                      width: 8), // Space between icon and text
                                  Text(userName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              if (lastMessageTime != null)
                                Text(
                                  lastMessageTime,
                                  style: const TextStyle(
                                      fontSize:
                                          14), // Adjust the font size as needed
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
          ),
        ],
      ),
    );
  }
}
