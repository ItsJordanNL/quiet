import 'package:quiet_app/constants/constants.dart';
import 'package:flutter/material.dart';

// Voucher class
class VoucherSponsor {
  final String imagePath;
  final String status;
  final String used;
  final Color textColor;

  VoucherSponsor({
    required this.imagePath,
    required this.status,
    required this.used,
    required this.textColor,
  });
}

// VoucherList widget
class VoucherListSponsor extends StatefulWidget {
  const VoucherListSponsor({super.key});

  @override
  State<VoucherListSponsor> createState() => _VoucherListSponsorState();
}

class _VoucherListSponsorState extends State<VoucherListSponsor> {
  // Information of the vouchers
  final List<VoucherSponsor> vouchers = [
    VoucherSponsor(
      imagePath: 'assets/images/psv_wedstrijd.png',
      status: "Gebruikt",
      used: "15-05-2024",
      textColor: primary,
    ),
    VoucherSponsor(
      imagePath: 'assets/images/zusje.png',
      status: "Niet gebruikt",
      used: "",
      textColor: unanswered,
    ),
    VoucherSponsor(
      imagePath: 'assets/images/ouwehands_panda.png',
      status: "Niet gebruikt",
      used: "",
      textColor: unanswered,
    ),
    VoucherSponsor(
      imagePath: 'assets/images/museum_mauritshuis.png',
      status: "Niet gebruikt",
      used: "",
      textColor: unanswered,
    ),
  ];

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
                          margin: EdgeInsets.only(top: screenWidth * 0.05),
           child: Card(
            child: Container(
              margin: EdgeInsets.all(screenWidth * 0.05),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "143",
                  style: TextStyle(
                      color: primary,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                Text("Geluksmomentjes aangeboden!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ),)
              ],
            ),),
          ),),
          Expanded(
            child: ListView.builder(
              itemCount: vouchers.length,
              itemBuilder: (context, index) {
                return VoucherCardSponsor(voucher: vouchers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// VoucherCard widget
class VoucherCardSponsor extends StatelessWidget {
  final VoucherSponsor voucher;

  const VoucherCardSponsor({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.all(screenWidth * 0.05),
      color: backgroundColor,
      child: Column(
        children: [
          // Image of voucher
          Container(
            margin: EdgeInsets.only(bottom: screenWidth * 0.05),
            child: SizedBox(
              width: double.infinity,
              height: screenWidth * 0.45,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(9.0),
                ),
                child: Image.asset(
                  voucher.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Status
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              children: [
                const Text(
                  "Status:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: secondaryText,
                      fontSize: 16),
                ),
                Container(margin: EdgeInsets.only(right: screenWidth * 0.01)),
                Text(
                  voucher.status,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: voucher.textColor),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // used at date
                    Container(
                      margin: EdgeInsets.only(bottom: screenWidth * 0.01),
                      child: Row(
                        children: [
                          const Text(
                            "Gebruikt op",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: secondaryText),
                          ),
                          Container(
                              margin:
                                  EdgeInsets.only(right: screenWidth * 0.01)),
                          Text(
                            voucher.used,
                            style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: secondaryText),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
