import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  ScanQRCodeState createState() => ScanQRCodeState();
}

class ScanQRCodeState extends State<ScanQRCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String validationMessage = '';
  bool isValid = false;
  bool isScanned = false;
  bool isCooldown = false;
  Color borderColor = Colors.transparent;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(validationMessage),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: 10.0, // Increased border width for better visibility
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isCooldown) {
        setState(() {
          result = scanData;
          _validateQRCode(result!.code!);
        });
      }
    });
  }

  Future<void> _validateQRCode(String qrCodeData) async {
    setState(() {
      isCooldown = true;
    });

    List<String> dataParts = qrCodeData.split(':');
    if (dataParts.length == 5) {
      String reservationId = dataParts[0];
      String reservationName = dataParts[1];
      String reservationAmount = dataParts[2];
      String reservationLocation = dataParts[3];
      String reservatedBy = dataParts[4];

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('reservations')
          .doc(reservationId)
          .get();
      if (doc.exists) {
        bool scanned = doc['scanned'];
        if (!scanned) {
          // Fetch user name from users collection
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(reservatedBy)
              .get();
          String userName = userDoc.exists ? userDoc['naam'] : 'Unknown User';

          await FirebaseFirestore.instance
              .collection('reservations')
              .doc(reservationId)
              .update({'scanned': true});
          setState(() {
            isValid = true;
            isScanned = false;
            validationMessage =
                'Geldige QR Code!\nNaam: $userName\nReservering: $reservationName\nAantal: $reservationAmount\nLocatie: $reservationLocation';
            borderColor = Colors.green;
          });
        } else {
          setState(() {
            isValid = false;
            isScanned = true;
            validationMessage = 'QR Code is al gescand!';
            borderColor = Colors.orange;
          });
        }
      } else {
        setState(() {
          isValid = false;
          isScanned = false;
          validationMessage = 'Ongeldige QR Code!';
          borderColor = Colors.red;
        });
      }
    } else {
      setState(() {
        isValid = false;
        isScanned = false;
        validationMessage = 'Ongeldig QR Code format!';
        borderColor = Colors.red;
      });
    }

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        borderColor = Colors.transparent;
        isCooldown = false;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
