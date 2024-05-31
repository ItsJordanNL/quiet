import "package:flutter/material.dart";
import 'package:quiet_app/screens/member/member.dart';
import 'package:quiet_app/screens/sponsor/sponsor.dart';
import 'package:quiet_app/screens/volunteer/volunteer.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose your role"),
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
                    builder: (context) => const Member_Main(),
                  ),
                );
              },
              child: Text('Member'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Volunteer_Main(),
                  ),
                );
              },
              child: Text('Volunteer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Sponsor_Main(),
                  ),
                );
              },
              child: Text('Sponsor'),
            ),
          ],
        ),
      ),
    );
  }
}