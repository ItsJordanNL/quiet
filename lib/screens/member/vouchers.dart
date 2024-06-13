import "package:flutter/material.dart";
import "package:quiet_app/screens/member/components/voucherlist.dart";
import "package:quiet_app/constants/constants.dart";

class VouchersPage extends StatefulWidget {
  const VouchersPage({super.key});

  @override
  State<VouchersPage> createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bekijk de vouchers"),
        foregroundColor: primaryText, // Set the appbar background color here
        backgroundColor: primary, // Set the appbar background color here
      ),
      body: const VoucherList(),
    );
  }
}
