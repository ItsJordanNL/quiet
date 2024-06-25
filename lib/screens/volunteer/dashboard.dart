import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiet_app/constants/constants.dart';
import 'package:quiet_app/screens/volunteer/components/dashboard_donutchart.dart';
import 'package:quiet_app/screens/volunteer/components/dashboard_questionlist.dart'; // Corrected import

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Username from firebase who logged in
  User? _currentUser;
  String _userName = 'Gebruiker'; 

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    if (_currentUser != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();
      if (userDoc.exists) {
        String fullName = userDoc['naam'];
        setState(() {
          _userName = fullName.split(' ').first;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          title: Text(
            "Hey $_userName, welke leden ga jij \nvandaag helpen?",
            style: const TextStyle(
              color: primaryText,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          backgroundColor: primary,
        ),
      ),
      body: Stack(
        children: [
          const DashboardDonutchart(),
          DashboardQuestionlist(nameVolunteer: _userName),
        ],
      ),
    );
  }
}
