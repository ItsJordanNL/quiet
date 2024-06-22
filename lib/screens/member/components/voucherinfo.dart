import 'dart:async';
import "package:flutter/material.dart";
import 'package:quiet_app/screens/member/components/voucherlist.dart';
import 'package:quiet_app/constants/constants.dart';
import 'package:quiet_app/screens/member/components/generate_qr_code.dart';

// Variable margin bottom
const space = 15.0;

class VoucherInfo extends StatefulWidget {
  final Voucher voucher;

  const VoucherInfo({super.key, required this.voucher});

  @override
  VoucherInfoState createState() => VoucherInfoState();
}

class VoucherInfoState extends State<VoucherInfo> {
  // Function timer
  late Timer _timer;
  Duration _timeRemaining = const Duration();

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.voucher.endTime.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeRemaining = widget.voucher.endTime.difference(DateTime.now());
        if (_timeRemaining.isNegative) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
  // End function timer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(3),
        child: AppBar(
          title: const Text(
            "",
          ),
          backgroundColor: primary,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            // Image of voucher
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Image.asset(
                  widget.voucher.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              // Back button
              Container(
                margin: const EdgeInsets.only(top: 20, left: 0),
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(45, 45),
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_left_rounded,
                      color: primary,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: space),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Category
                      Text(
                        widget.voucher.category,
                        style: const TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: primary),
                      ),
                      // Timer
                      Text(
                        " ${_formatDuration(_timeRemaining)}",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                // Title voucher
                Container(
                  margin: const EdgeInsets.only(bottom: space),
                  child: Text(
                    widget.voucher.titleVoucher,
                    style: const TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: secondaryText),
                  ),
                ),
                // How many persons
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      const Opacity(
                        opacity: 0.40,
                        child: Icon(Icons.person_outline_rounded),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                      ),
                      Opacity(
                        opacity: 0.40,
                        child: Text(
                          widget.voucher.persons,
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
                // Location
                Container(
                  margin: const EdgeInsets.only(bottom: space),
                  child: Row(
                    children: [
                      const Opacity(
                        opacity: 0.40,
                        child: Icon(Icons.location_on_rounded),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                      ),
                      Opacity(
                        opacity: 0.40,
                        child: Text(
                          widget.voucher.location,
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
                // Information about how it works
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    'Activeer deze voucher, voordat de timer op 0 staat.',
                    style: TextStyle(fontSize: 16, color: secondaryText),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  child: const Text(
                    "Na het activeren van uw voucher, ontvangt u een QR code om toegang te krijgen tot uw geluksmomentje.",
                    style: TextStyle(fontSize: 16, color: secondaryText),
                  ),
                ),
                // button activeer
                Container(
                  margin: const EdgeInsets.only(bottom: space),
                  child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(primary)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GenerateQRCode(
                                      reservationName:
                                          widget.voucher.titleVoucher,
                                      reservationAmount: widget.voucher.persons,
                                      reservationLocation:
                                          widget.voucher.location,
                                    )),
                          );
                        },
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Activeer",
                                style: TextStyle(
                                  color: primaryText,
                                  fontFamily: 'Roboto-Medium',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: primaryText,
                              ),
                            ]),
                      )),
                ),

                // button contact
                SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(secondaryText)),
                      onPressed: () {},
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vragen? Verstuur een bericht",
                              style: TextStyle(
                                  color: primaryText,
                                  fontFamily: 'Roboto-Medium',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: primaryText,
                            ),
                          ]),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
