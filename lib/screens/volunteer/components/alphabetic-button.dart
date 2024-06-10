import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';
import 'package:quiet_app/screens/volunteer/components/chat-list.dart';

class AlphabeticButton extends StatelessWidget {
  final List<Chat> chats; // Pass the list of chats to perform sorting
  final Function(List<Chat>) onPressed;

  AlphabeticButton({
    required this.chats,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Sort Alphabetically', // Provide a tooltip message
      child: GestureDetector(
        onTap: () {
          // Sort the list alphabetically based on the name of the person
          List<Chat> sortedChats = List.from(chats);
          sortedChats.sort((a, b) => a.name.compareTo(b.name));
          onPressed(sortedChats); // Call the callback with sorted list
        },
        child: Container(
          width: 40, // Adjust width as needed
          height: 40, // Adjust height as needed
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: primary,
          ),
          child: const Center(
            child: Icon(
              Icons.sort_by_alpha,
              color: Colors.white,
              size: 20, // Adjust icon size as needed
            ),
          ),
        ),
      ),
    );
  }
}
