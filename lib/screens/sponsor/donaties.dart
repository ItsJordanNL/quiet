import 'package:flutter/material.dart';
import "package:quiet_app/constants/constants.dart";
import 'package:quiet_app/screens/sponsor/components/scan_qr_code.dart';

class DonatiesPage extends StatefulWidget {
  const DonatiesPage({super.key});

  @override
  State<DonatiesPage> createState() => _DonatiesPageState();
}

class _DonatiesPageState extends State<DonatiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mijn Donaties"),
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
      ),
    );
  }
}
