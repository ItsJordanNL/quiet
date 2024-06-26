// import 'package:flutter/widgets.dart';
// import 'package:quiet_app/constants/constants.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';

// // Voucher class
// class VoucherSponsor {
//   final String imagePath;
//   final String titleVoucher;
//   final String donation;
//   final String persons;

//   VoucherSponsor({
//     required this.imagePath,
//     required this.titleVoucher,
//     required this.persons,
//     required this.donation,
//   });
// }

// // VoucherList widget
// class VoucherListSponsor extends StatefulWidget {
//   const VoucherListSponsor({super.key});

//   @override
//   State<VoucherListSponsor> createState() => _VoucherListSponsorState();
// }

// class _VoucherListSponsorState extends State<VoucherListSponsor> {
//   // Information of the vouchers
//   final List<VoucherSponsor> vouchers = [
//     VoucherSponsor(
//         imagePath: 'assets/images/psv_wedstrijd.png',
//         titleVoucher: "Voetbalwedstrijd PSV - Ajax",
//         persons: "2 personen",
//         donation: "Gedoneerd op 12-05-2024"),
//     VoucherSponsor(
//         imagePath: 'assets/images/zusje.png',
//         titleVoucher: "Avondvullend dineren bij 't Zusje",
//         persons: "4 personen",
//         donation: "Gedoneerd op:"),
//     VoucherSponsor(
//         imagePath: 'assets/images/ouwehands_panda.png',
//         titleVoucher: "Ouwehands Dierenparktickets",
//         persons: "6 personen",
//         donation: "Gedoneerd op:"),
//     VoucherSponsor(
//       imagePath: 'assets/images/museum_mauritshuis.png',
//       titleVoucher: "Museum Mauritshuis tickets",
//       persons: "2 personen",
//       donation: "Gedoneerd op:",
//     )
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: vouchers.length,
//         itemBuilder: (context, index) {
//           return VoucherCardSponsor(voucher: vouchers[index]);
//         },
//       ),
//     );
//   }
// }

// // VoucherCard widget
// class VoucherCardSponsor extends StatefulWidget {
//   final VoucherSponsor voucher;

//   const VoucherCardSponsor({super.key, required this.voucher});

//   @override
//   _VoucherCardSponsorState createState() => _VoucherCardSponsorState();
// }

// class _VoucherCardSponsorState extends State<VoucherCardSponsor> {
//   @override
//   Widget build(BuildContext context) {
//     // card of geluksmomentje

//     return Card(
//       margin: const EdgeInsets.all(20),
//       color: backgroundColor,
//       child: Column(children: [
//         // Image of voucher
//         Container(
//           margin: const EdgeInsets.only(bottom: 15.0),
//           child: SizedBox(
//             width: double.infinity,
//             height: 180,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(8.0),
//                 topRight: Radius.circular(9.0),
//               ),
//               child: Image.asset(
//                 widget.voucher.imagePath,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//         // Title of voucher
//         Container(
//           margin: const EdgeInsets.only(left: 15.0, right: 15.0),
//           child: Row(
//             children: [
//               Text(
//                 widget.voucher.titleVoucher,
//                 style: const TextStyle(
//                     fontFamily: 'Roboto',
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // how many persons
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 2),
//                     child: Row(
//                       children: [
//                         Container(),
//                         Text(
//                           widget.voucher.persons,
//                           style: const TextStyle(
//                               fontFamily: 'Roboto',
//                               fontSize: 16,
//                               fontWeight: FontWeight.normal),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Donation
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 2),
//                     child: Row(
//                       children: [
//                         Container(),
//                         Text(
//                           widget.voucher.donation,
//                           style: const TextStyle(
//                               fontFamily: 'Roboto',
//                               fontSize: 16,
//                               fontWeight: FontWeight.normal),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 15),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 5),
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         height: 45,
//                         child: ElevatedButton(
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 WidgetStateProperty.all<Color>(primary),
//                           ),
//                           onPressed: () {},
//                           child: const Row(
//                             children: [
//                               Text(
//                                 'Bekijk',
//                                 style: TextStyle(
//                                     color: primaryText,
//                                     fontFamily: 'Roboto-Medium',
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                               Icon(
//                                 Icons.keyboard_arrow_right_rounded,
//                                 color: primaryText,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ]),
//     );
//   }
// }

import 'package:flutter/widgets.dart';
import 'package:quiet_app/constants/constants.dart';
import 'package:flutter/material.dart';

// Voucher class
class VoucherSponsor {
  final String imagePath;
  final String titleVoucher;
  final String donation;
  final String persons;

  VoucherSponsor({
    required this.imagePath,
    required this.titleVoucher,
    required this.persons,
    required this.donation,
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
        titleVoucher: "Voetbalwedstrijd PSV - Ajax",
        persons: "2 personen",
        donation: "Gedoneerd op 12-05-2024"),
    VoucherSponsor(
        imagePath: 'assets/images/zusje.png',
        titleVoucher: "Avondvullend dineren bij 't Zusje",
        persons: "4 personen",
        donation: "Gedoneerd op:"),
    VoucherSponsor(
        imagePath: 'assets/images/ouwehands_panda.png',
        titleVoucher: "Ouwehands Dierenparktickets",
        persons: "6 personen",
        donation: "Gedoneerd op:"),
    VoucherSponsor(
      imagePath: 'assets/images/museum_mauritshuis.png',
      titleVoucher: "Museum Mauritshuis tickets",
      persons: "2 personen",
      donation: "Gedoneerd op:",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          return VoucherCardSponsor(voucher: vouchers[index]);
        },
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
      child: Column(children: [
        // Image of voucher
        Container(
          margin: EdgeInsets.only(bottom: screenWidth * 0.05),
          child: SizedBox(
            width: double.infinity,
            height: screenWidth * 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
              child: Image.asset(
                voucher.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Title of voucher
        Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            children: [
              Text(
                voucher.titleVoucher,
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
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
                  // how many persons
                  Container(
                    margin: EdgeInsets.only(bottom: screenWidth * 0.01),
                    child: Row(
                      children: [
                        Text(
                          voucher.persons,
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: secondaryText),
                        ),
                      ],
                    ),
                  ),
                  // Donation
                  Container(
                    margin: EdgeInsets.only(bottom: screenWidth * 0.01),
                    child: Row(
                      children: [
                        Text(
                          voucher.donation,
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: secondaryText),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenWidth * 0.05),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenWidth * 0.015),
                    child: Row(
                      children: [
                        SizedBox(
                          height: screenWidth * 0.1,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  primary), 
                            ),
                            onPressed: () {},
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
                                  color: backgroundColor, 
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
            ],
          ),
        ),
      ]),
    );
  }
}
