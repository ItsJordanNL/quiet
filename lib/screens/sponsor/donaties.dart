import 'package:flutter/material.dart';
import "package:quiet_app/constants/constants.dart";
import 'package:quiet_app/screens/sponsor/components/scan_qr_code.dart';
import 'package:quiet_app/screens/sponsor/components/voucherlist_sponsor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonatiesPage extends StatefulWidget {
  const DonatiesPage({super.key});

  @override
  State<DonatiesPage> createState() => _DonatiesPageState();
}

class _DonatiesPageState extends State<DonatiesPage> {
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
          _userName = fullName.split(' ').last;
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
          "Hallo $_userName, hier ziet u al uw \n gegeven geluksmomentjes?",
          style: const TextStyle(
            color: primaryText,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        foregroundColor: primaryText,
        backgroundColor: primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScanQRCode()),
              );
            },
          ),
        ],
      ),),
      body: const VoucherListSponsor(),
    );
  }
}
