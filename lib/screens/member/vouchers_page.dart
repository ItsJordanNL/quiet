import "package:flutter/material.dart";

class VouchersPage extends StatefulWidget {
  const VouchersPage({super.key});

  @override
  State<VouchersPage> createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose a voucher"),),
    );
  }
}