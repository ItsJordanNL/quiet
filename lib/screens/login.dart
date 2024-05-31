import "package:flutter/material.dart";
import 'package:quiet_app/screens/member/member.dart';
import 'package:quiet_app/screens/sponsor/sponsor.dart';
import 'package:quiet_app/screens/volunteer/volunteer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose your role"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MemberMain(),
                  ),
                );
              },
              child: const Text('Member'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VolunteerMain(),
                  ),
                );
              },
              child: const Text('Volunteer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SponsorMain(),
                  ),
                );
              },
              child: const Text('Sponsor'),
            ),
          ],
        ),
      ),
    );
  }
}