import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';
import 'package:quiet_app/screens/volunteer/components/chat-list.dart';

class AlphabeticButton extends StatelessWidget {
  final List<Chat> chats;
  final Function(List<Chat>) onPressed;

  AlphabeticButton({
    required this.chats,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Sort Alphabetically', 
      child: GestureDetector(
        onTap: () {
          
          List<Chat> sortedChats = List.from(chats);
          sortedChats.sort((a, b) => a.name.compareTo(b.name));
          onPressed(sortedChats); 
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: primary,
          ),
          child: const Center(
            child: Icon(
              Icons.sort_by_alpha,
              color: Colors.white,
              size: 20, 
            ),
          ),
        ),
      ),
    );
  }
}
