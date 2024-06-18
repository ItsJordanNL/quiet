import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiet_app/screens/login.dart';
import "package:quiet_app/constants/constants.dart";

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    // Navigate back to login page after logging out
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leden Account"),
        foregroundColor: primaryText,
        backgroundColor: primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: Text(
            "Ingelogd met: ${FirebaseAuth.instance.currentUser?.email ?? 'email'}"),
      ),
    );
  }
}
