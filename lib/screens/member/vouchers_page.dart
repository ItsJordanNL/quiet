import "package:flutter/material.dart";

class Vouchers_Page extends StatefulWidget {
  const Vouchers_Page({super.key});

  @override
  State<Vouchers_Page> createState() => _Vouchers_PageState();
}

class _Vouchers_PageState extends State<Vouchers_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose a voucher"),),
    );
  }
}