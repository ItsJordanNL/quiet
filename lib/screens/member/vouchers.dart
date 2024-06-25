import "package:flutter/material.dart";
import "package:quiet_app/screens/member/components/voucherlist.dart";
import "package:quiet_app/constants/constants.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VouchersPage extends StatefulWidget {
  const VouchersPage({super.key});

  @override
  State<VouchersPage> createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
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
          automaticallyImplyLeading: false, // Hide the back button
          title: Text(
            "Hey $_userName, wat wordt jouw \n geluksmomentje?",
            style: const TextStyle(
              color: primaryText,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          backgroundColor: primary,
        ),
      ),
      body: const VoucherList(),
    );
  }
}
