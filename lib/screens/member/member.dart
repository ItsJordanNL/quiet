import "package:flutter/material.dart";
import "package:quiet_app/constants/constants.dart";
import "package:quiet_app/screens/member/account_page.dart";
import "package:quiet_app/screens/member/chat_page.dart";
import "package:quiet_app/screens/member/vouchers_page.dart";

class Member_Main extends StatefulWidget {
  const Member_Main({super.key});

  @override
  State<Member_Main> createState() => _Member_MainState();
}

class _Member_MainState extends State<Member_Main> {
  int index = 0;
    final screens = [
    const Vouchers_Page(), 
    const Chat_Page(),
    const Account_Page(),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(data: const NavigationBarThemeData( indicatorColor: primary), child: NavigationBar(
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
                icon: Icon(Icons.chat_outlined),
                selectedIcon: Icon(Icons.chat_rounded, color: backgroundColor),
                label: 'Chat'),
            NavigationDestination(
                icon: Icon(Icons.account_circle_rounded),
                selectedIcon:
                    Icon(Icons.account_circle_rounded, color: backgroundColor),
                label: 'Account'),
          ],
        ), ),
    );
  }
}