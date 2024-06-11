import "package:flutter/material.dart";

import 'package:quiet_app/constants/constants.dart';

const space = 8.5;

class VoucherInfo extends StatefulWidget {
  const VoucherInfo({super.key});

  @override
  State<VoucherInfo> createState() => _VoucherInfo();
}

class _VoucherInfo extends State<VoucherInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Image of voucher
        Stack(children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Image.asset(
              'assets/images/psv_wedstrijd.png',
              fit: BoxFit.cover,
            ),
          ),
          // Back button 
          Padding(padding: const EdgeInsets.only(top: space),
          child: Row(
            children: [
              SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(45, 45),
                        shape: const CircleBorder()),
                    onPressed: () {},
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left_rounded,
                            color: primary,
                            size: 35,
                          ),
                        ]),
                  )),
            ],
          ),
          ),
        ]),

        Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Category voucher
                const Padding(
                  padding: EdgeInsets.only(
                    top: space,
                  ),
                  child: Text(
                    "Entertainment",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: primary),
                  ),
                ),
                // Title voucher
                const Padding(
                  padding: EdgeInsets.only(top: space),
                  child: Text(
                    "Voetbalwedstrijd PSV-Ajax",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: secondaryText),
                  ),
                ),

                // Number of persons
                Container(
                  margin: const EdgeInsets.only(top: space, bottom: 2),
                  child: const Row(
                    children: [
                      Opacity(
                        opacity: 0.25,
                        child: Icon(Icons.person_outline_rounded),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Opacity(
                        opacity: 0.25,
                        child: Text(
                          "2 personen",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),

                // Location voucher
                const Row(
                  children: [
                    Opacity(
                      opacity: 0.25,
                      child: Icon(Icons.location_on_rounded),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Opacity(
                      opacity: 0.25,
                      child: Text(
                        'Frederiklaan 10A, Eindhoven',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                // Text about use of voucher
                const Padding(
                  padding: EdgeInsets.only(top: space, bottom: space),
                  child: Text(
                    'Wanneer u deze voucher reserveert, is deze beschikbaar voor 3 dagen om te activeren.',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: secondaryText),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: space),
                  child: Text(
                    "Na het activeren van uw voucher, ontvangt u een QR code om toegang te krijgen tot uw geluksmomentje.",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: secondaryText),
                  ),
                ),

                // button reserveer
                Container(
                  margin: const EdgeInsets.only(bottom: space),
                  child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(primary)),
                        onPressed: () {},
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Reserveer",
                                style: TextStyle(
                                  color: primaryText,
                                  fontFamily: 'Roboto-Medium',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
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
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: primaryText,
                            ),
                          ]),
                    )),
              ],
            )),
      ],
    );
  }
}
