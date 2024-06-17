// import 'package:flutter/material.dart';
// import 'package:quiet_app/constants/constants.dart';

// class DashboardQuestionFilter extends StatefulWidget {
//   const DashboardQuestionFilter({super.key});

//   @override
//   State<DashboardQuestionFilter> createState() =>
//       _DashboardQuestionFilterState();
// }

// class _DashboardQuestionFilterState extends State<DashboardQuestionFilter> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Text questions members
//         Container(
//           margin: const EdgeInsets.only(top: 20, bottom: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Vragen van Leden',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               // Filter button
//               SizedBox(
//                   width: 40,
//                   height: 40,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       shape: const CircleBorder(),
//                       padding: const EdgeInsets.all(10),
//                       backgroundColor: primary,
//                     ),
//                     child: const Icon(
//                       Icons.check,
//                       size: 20,
//                       color: backgroundColor,
//                     ),
//                   )),
//             ],
//           ),
//         ),
//         // Date
//         Container(
//           margin: const EdgeInsets.only(bottom: 15),
//           width: 96,
//           height: 23,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: secondary,
//           ),
//           child: const Text(
//             'juni',
//             style: TextStyle(fontSize: 16),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';

class DashboardQuestionFilter extends StatefulWidget {
  const DashboardQuestionFilter({super.key});

  @override
  State<DashboardQuestionFilter> createState() => _DashboardQuestionFilterState();
}

class _DashboardQuestionFilterState extends State<DashboardQuestionFilter> {
// Dropdown items
  final List<String> _dropdownItems = ['Vragen van Leden', 'Vragen voor Jou'];
  String _selectedItem = 'Vragen van Leden';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown menu
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: _selectedItem,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                underline: Container(
                  height: 2,
                  color: primary,
                ),
                
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue!;
                  });
                },
                items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: secondaryText),),
                  );
                }).toList(),
              ),
              
              // Filter button
              SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                    backgroundColor: primary,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 20,
                    color: backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Date
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: 96,
          height: 23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: secondary,
          ),
          child: const Text(
            'juni',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

