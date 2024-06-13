import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';
import 'package:quiet_app/screens/member/components/voucherinfo.dart';

// Variabeles for vouchers
class Voucher {
  final String imagePath;
  final String titleVoucher;
  final String persons;
  final String location;

  Voucher({
    required this.imagePath,
    required this.titleVoucher,
    required this.persons,
    required this.location,
  });
}

class VoucherList extends StatefulWidget {
  const VoucherList({super.key});

  @override
  State<VoucherList> createState() => _VoucherList();
}

class _VoucherList extends State<VoucherList> {
  // Information of the vouchers
  final List<Voucher> vouchers = [
    Voucher(
        imagePath: 'assets/images/psv_wedstrijd.png',
        titleVoucher: "Voetbalwedstrijd PSV - Ajax tickets",
        persons: "2 personen",
        location: "Eindhoven"),
    Voucher(
        imagePath: 'assets/images/zusje.png',
        titleVoucher: "Avondvullend dineren bij 't Zusje",
        persons: "4 personen",
        location: "Eindhoven"),
    Voucher(
        imagePath: 'assets/images/ouwehands_panda.png',
        titleVoucher: "Ouwehands Dierenparktickets",
        persons: "6 personen",
        location: "Rhenen"),
    Voucher(
        imagePath: 'assets/images/museum_mauritshuis.png',
        titleVoucher: "Museum Mauritshuis tickets",
        persons: "2 personen",
        location: "Den Haag")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          // Made lay-out of the card
          return Card(
            margin: const EdgeInsets.all(20),
            color: backgroundColor,
            child: Column(
              children: [
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
                        vouchers[index].imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Title of voucher
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text(
                        vouchers[index].titleVoucher,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // How many persons
                          Row(
                            children: [
                              const Opacity(
                                opacity: 0.25,
                                child: Icon(Icons.person_outline_rounded),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Opacity(
                                opacity: 0.25,
                                child: Text(
                                  vouchers[index].persons,
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                          // Location
                          Row(
                            children: [
                              const Opacity(
                                opacity: 0.25,
                                child: Icon(Icons.location_on_rounded),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Opacity(
                                opacity: 0.25,
                                child: Text(
                                  vouchers[index].location,
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      // Button
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(primary),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const VoucherInfo()),);
                          },
                          child: const Row(
                            children: [
                              Text(
                                'Reserveer',
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
          );
        },
      ),
    );
  }
}
