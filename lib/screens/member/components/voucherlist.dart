import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({super.key});

  @override
  State<VoucherList> createState() => _VoucherList();
}

class _VoucherList extends State<VoucherList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const <Widget>[
          Card(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/psv_wedstrijd.jpeg'),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Voetbalwedstrijd PSV - Ajax tickets"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(
                      left: 15.0,
                      right: 7.5,
                    
                    ),
                    child: Icon(
                      Icons.person_outline_rounded,
                    ),
                    ),
                     Text("2 personen"),
                  ],
                ),
            
                Row(
                  children: [
                     Padding(padding: EdgeInsets.only(
                      left: 15.0,
                      right: 7.5,
                  
                    ),
                    child: Icon(
                      Icons.location_on_rounded,
                    ),
                     ),
                    Text("Eindhoven"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
