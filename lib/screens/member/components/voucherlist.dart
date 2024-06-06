import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:quiet_app/constants/constants.dart';
import 'package:quiet_app/constants/constants.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({super.key});

  @override
  State<VoucherList> createState() => _VoucherList();
}

// class _VoucherList extends State<VoucherList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: const <Widget>[
//           Card(
//             margin: EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(8.0),
//                     topRight: Radius.circular(8.0),
//                   ),
//                   child: Image(
//                     image: AssetImage('assets/images/psv_wedstrijd.png'),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(15.0),
//                       child: Text("Voetbalwedstrijd PSV - Ajax tickets"),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                         left: 12.0,
//                         right: 7.5,
//                         bottom: 3.0,
//                       ),
//                       child: Icon(
//                         Icons.person_outline_rounded,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(bottom: 3.0),
//                       child: Text("2 personen"),
//                     ),
//                     ElevatedButton(onPressed: null, child: Text('Reserveer'))
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.only(left: 12.0, right: 7.5, bottom: 15.0),
//                       child: Icon(
//                         Icons.location_on_rounded,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(bottom: 15.0),
//                       child: Text("Eindhoven"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class _VoucherList extends State<VoucherList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(20),
            color: backgroundColor,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image(
                      image: AssetImage('assets/images/psv_wedstrijd.png'),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text(
                        "Voetbalwedstrijd PSV - Ajax tickets",
                        style: TextStyle(
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Opacity(opacity: 0.25,
                              child: Icon(Icons.person_outline_rounded),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Opacity(opacity: 0.25,
                              child: Text(
                                "2 personen",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              Opacity(opacity: 0.25,
                              child: Icon(Icons.location_on_rounded),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Opacity(opacity: 0.25,
                              child: Text(
                                "Eindhoven",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(primary),
                          ),
                          onPressed: () {},
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
          )
        ],
      ),
    );
  }
}
