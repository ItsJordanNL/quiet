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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 1,
            color: Colors.black12,
          ),
          NavigationBarTheme(
            data: const NavigationBarThemeData(indicatorColor: primary),
            child: NavigationBar(
              backgroundColor: backgroundColor,
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.dashboard_outlined,
                  ),
                  selectedIcon:
                      Icon(Icons.dashboard_rounded, color: backgroundColor),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                    icon: Icon(
                      Icons.chat_outlined,
                      color: secondaryText,
                    ),
                    selectedIcon:
                        Icon(Icons.chat_rounded, color: backgroundColor),
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
