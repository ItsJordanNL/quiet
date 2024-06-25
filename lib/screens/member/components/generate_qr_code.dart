import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GenerateQRCode extends StatelessWidget {
  final String reservationName;
  final String reservationAmount;
  final String reservationLocation;

  const GenerateQRCode(
      {super.key, required this.reservationName,
      required this.reservationAmount,
      required this.reservationLocation});

  @override
  Widget build(BuildContext context) {
    String reservationId = _generateUniqueId();
    String userId = _getCurrentUserId();

    String data =
        '$reservationId:$reservationName:$reservationAmount:$reservationLocation:$userId';
    _storeQRCodeData(reservationId, reservationName, reservationAmount,
        reservationLocation, userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: Center(
        child: QrImageView(
          data: data,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }

  String _generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  String _getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? 'UnknownUser';
  }

  Future<void> _storeQRCodeData(String reservationId, String reservationName,
      String reservationAmount, String reservationLocation, String userId) async {
    await FirebaseFirestore.instance
        .collection('reservations')
        .doc(reservationId)
        .set({
      'reservationId': reservationId,
      'reservationName': reservationName,
      'reservationAmount': reservationAmount,
      'reservationLocation': reservationLocation,
      'scanned': false,
      'reservatedBy': userId, // Added reservatedBy field
    });
  }
}
