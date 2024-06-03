import "package:flutter/material.dart";
import "package:quiet_app/constants/constants.dart";
import "package:quiet_app/screens/sponsor/account.dart";
import "package:quiet_app/screens/sponsor/chat.dart";
import "package:quiet_app/screens/sponsor/donaties.dart";

class SponsorMain extends StatefulWidget {
  const SponsorMain({super.key});

  @override
  State<SponsorMain> createState() => _SponsorMainState();
}

class _SponsorMainState extends State<SponsorMain> {
  int index = 0;
    final screens = [
      const DonatiesPage(),
      const ChatPage(),
      const AccountPage(),
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
                Icons.volunteer_activism_outlined,
              ),
              selectedIcon: Icon(Icons.volunteer_activism_rounded,
                  color: backgroundColor),
              label: 'Donaties',
            ),
            NavigationDestination(
                icon: Icon(Icons.chat_outlined, color: secondaryText,),
                selectedIcon: Icon(Icons.chat_rounded, color: backgroundColor),
                label: 'Chat'),
            NavigationDestination(
                icon: Icon(Icons.person_outline_rounded, color: secondaryText,),
                selectedIcon:
                    Icon(Icons.person, color: backgroundColor),
                label: 'Account'),
          ],
        ), ),
    );
  }
}