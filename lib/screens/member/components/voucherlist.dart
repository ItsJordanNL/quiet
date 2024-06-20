import 'package:quiet_app/constants/constants.dart';
import 'package:quiet_app/screens/member/components/voucherinfo.dart';
import 'dart:async';
import 'package:flutter/material.dart';

// Voucher class
class Voucher {
  final String imagePath;
  final String titleVoucher;
  final String persons;
  final String location;
  final String category;
  final DateTime endTime;

  Voucher({
    required this.imagePath,
    required this.titleVoucher,
    required this.persons,
    required this.location,
    required this.category,
    required this.endTime,
  });
}

// VoucherList widget
class VoucherList extends StatefulWidget {
  const VoucherList({super.key});

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  // Information of the vouchers
  final List<Voucher> vouchers = [
    Voucher(
      imagePath: 'assets/images/psv_wedstrijd.png',
      titleVoucher: "Voetbalwedstrijd PSV - Ajax",
      persons: "2 personen",
      location: "Eindhoven",
      category: "Entertainment",
      endTime: DateTime.now()
          .add(const Duration(hours: 2, minutes: 30)), // Example end time
    ),
    Voucher(
      imagePath: 'assets/images/zusje.png',
      titleVoucher: "Avondvullend dineren bij 't Zusje",
      persons: "4 personen",
      location: "Eindhoven",
      category: "Dineren",
      endTime:
          DateTime.now().add(const Duration(minutes: 25)), // 
    ),
    Voucher(
      imagePath: 'assets/images/ouwehands_panda.png',
      titleVoucher: "Ouwehands Dierenparktickets",
      persons: "6 personen",
       category: "Entertainment",
      location: "Rhenen",
      endTime:
          DateTime.now().add(const Duration(minutes: 15)), 
    ),
    Voucher(
      imagePath: 'assets/images/museum_mauritshuis.png',
      titleVoucher: "Museum Mauritshuis tickets",
      persons: "2 personen",
      location: "Den Haag",
       category: "Cultuur",
      endTime:
          DateTime.now().add(const Duration(minutes: 10)), // 
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          return VoucherCard(voucher: vouchers[index]);
        },
      ),
    );
  }
}

// VoucherCard widget
class VoucherCard extends StatefulWidget {
  final Voucher voucher;

  const VoucherCard({super.key, required this.voucher});

  @override
  _VoucherCardState createState() => _VoucherCardState();
}

class _VoucherCardState extends State<VoucherCard> {
  // Variables timer
  late Timer _timer;
  Duration _timeRemaining = const Duration();

// Function timer
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
    // card of geluksmomentje
    return Card(
      margin: const EdgeInsets.all(20),
      color: backgroundColor,
      child: Column(
        children: [
          // Image of voucher
          Container(
            margin: const EdgeInsets.only(bottom: 15.0),
            child: SizedBox(
              width: double.infinity,
              height: 180,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(9.0),
                ),
                child: Image.asset(
                  widget.voucher.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Title of voucher
          Container(
            margin: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              children: [
                Text(
                  widget.voucher.titleVoucher,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // how many persons
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        children: [
                          const Opacity(
                            opacity: 0.4,
                            child: Icon(Icons.person_outline_rounded),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                          ),
                          Opacity(
                            opacity: 0.4,
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
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          const Opacity(
                            opacity: 0.4,
                            child: Icon(Icons.location_on_rounded),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                          ),
                          Opacity(
                            opacity: 0.4,
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
                    // Timer
                    Container(
                      margin: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        _formatDuration(_timeRemaining),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: secondaryText,
                        ),
                      ),
                    )
                  ],
                ),
                // Button bekijk
                Container(
                  margin: const EdgeInsets.only(top: 37),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(primary),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  VoucherInfo(voucher: widget.voucher,)),
                            );
                          },
                          child: const Row(
                            children: [
                              Text(
                                'Bekijk',
                                style: TextStyle(
                                    color: primaryText,
                                    fontFamily: 'Roboto-Medium',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: primaryText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
