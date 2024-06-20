import "package:flutter/material.dart";
import "package:quiet_app/constants/constants.dart";
import "package:quiet_app/screens/member/account.dart";
import "package:quiet_app/screens/member/chat.dart";
import "package:quiet_app/screens/member/vouchers.dart";

class MemberMain extends StatefulWidget {
  const MemberMain({super.key});

  @override
  State<MemberMain> createState() => _MemberMainState();
}

class _MemberMainState extends State<MemberMain> {
  int index = 0;
  final screens = [
    const VouchersPage(),
    const ChatPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 1,
            color: Colors.grey, // Customize the color as needed
          ),
          NavigationBarTheme(
            data: const NavigationBarThemeData(indicatorColor: primary),
            child: NavigationBar(
              backgroundColor: backgroundColor,
              selectedIndex: index,
              onDestinationSelected: (index) => setState(() => this.index = index),
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.confirmation_number_outlined,
                  ),
                  selectedIcon: Icon(Icons.confirmation_number_rounded,
                      color: backgroundColor),
                  label: 'Vouchers',
                ),
                NavigationDestination(
                    icon: Icon(
                      Icons.chat_outlined,
                      color: secondaryText,
                    ),
                    selectedIcon: Icon(Icons.chat_rounded, color: backgroundColor),
                    label: 'Chat'),
                NavigationDestination(
                    icon: Icon(
                      Icons.person_outline_rounded,
                      color: secondaryText,
                    ),
                    selectedIcon: Icon(Icons.person, color: backgroundColor),
                    label: 'Account'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
