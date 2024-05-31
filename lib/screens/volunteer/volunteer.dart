import "package:flutter/material.dart";
import "package:quiet_app/constants/constants.dart";
import "package:quiet_app/screens/volunteer/account.dart";
import "package:quiet_app/screens/volunteer/chat.dart";
import "package:quiet_app/screens/volunteer/dashboard.dart";

class VolunteerMain extends StatefulWidget {
  const VolunteerMain({super.key});

  @override
  State<VolunteerMain> createState() => _VolunteerMainState();
}

class _VolunteerMainState extends State<VolunteerMain> {
  int index = 0;
    final screens = [
      const DashboardPage(),
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
                Icons.confirmation_number_outlined,
              ),
              selectedIcon: Icon(Icons.confirmation_number_rounded,
                  color: backgroundColor),
              label: 'Vouchers',
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