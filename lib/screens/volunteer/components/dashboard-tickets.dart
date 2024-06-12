import 'dart:ffi';

import 'package:flutter/material.dart';

// import 'package:pie_chart/pie_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:quiet_app/constants/constants.dart';

Map<String, double> dataMap = {
  "8 Openstaande vragen": 8,
  "7 In behandeling": 7,
  "8 Afgehandeld": 8,
};

class DashboardTickets extends StatefulWidget {
  const DashboardTickets({super.key});

  @override
  State<DashboardTickets> createState() => _DashboardTicketsState();
}

class _DashboardTicketsState extends State<DashboardTickets> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body:
    //   Container(
    //     margin: const EdgeInsets.all(20),
    //  child: Column(
    //     children: [
    //       PieChart(
    //         legendOptions: const LegendOptions(
    //           showLegendsInRow: false,
    //           legendPosition: LegendPosition.left,
    //           showLegends: true,
    //           legendShape:BoxShape.circle,
    //           legendTextStyle: TextStyle(
    //             fontWeight: FontWeight.normal,
    //           ),
    //         ),
    //          dataMap: dataMap,
    //         animationDuration: const Duration(milliseconds: 800),
    //         chartRadius: MediaQuery.of(context).size.width / 3.2,
    //         initialAngleInDegree: 0,
    //         chartType: ChartType.ring,
    //         ringStrokeWidth: 4,
    //         centerText: "Totaal aantal \nvragen",
    //         chartValuesOptions: const ChartValuesOptions(
    //           showChartValueBackground: true,
    //           showChartValues: false,
    //           showChartValuesInPercentage: false,
    //           showChartValuesOutside: true,
    //           decimalPlaces: 1,
    //         ),
    //       )
    //     ],
    //   ),
    //   ),
    // );
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 200,
//           child: PieChart(
//             PieChartData(
//               sections: [
//                 PieChartSectionData(
//                   color: Colors.red,
//                   value: 8,
//                   title: '',
//                   radius: 5,
//                   titleStyle: TextStyle(fontSize: 16),
//                 ),
//                 PieChartSectionData(
//                   color: Colors.orange,
//                   value: 7,
//                   title: '',
//                   radius: 5,
//                   titleStyle: TextStyle(fontSize: 16),
//                 ),
//                 PieChartSectionData(
//                   color: Colors.green,
//                   value: 8,
//                   title: '',
//                   radius: 5,
//                   titleStyle: TextStyle(fontSize: 16),
//                 ),
//               ],
//               centerSpaceRadius: 40,
//               sectionsSpace: 2,
//             ),
//           ),
//           ),
//           const Center(
//             child:
//                 Text('Totaal aantal \nvragen', style: TextStyle(fontSize: 16)),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(width: 10, height: 10, color: Colors.red),
//                   SizedBox(width: 5),
//                   Text('8 Openstaande vragen', style: TextStyle(fontSize: 16)),
//                 ],
//               ),
//               SizedBox(height: 5),
//               Row(
//                 children: [
//                   Container(width: 10, height: 10, color: Colors.orange),
//                   SizedBox(width: 5),
//                   Text('7 In behandeling', style: TextStyle(fontSize: 16)),
//                 ],
//               ),
//               SizedBox(height: 5),
//               Row(
//                 children: [
//                   Container(width: 10, height: 10, color: Colors.green),
//                   SizedBox(width: 5),
//                   Text('8 Afgehandeld', style: TextStyle(fontSize: 16)),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

//     return Stack(
//       children: [
//         SizedBox(
//           height: 200,
//           width: 200,
//           child: PieChart(
//             PieChartData(
//               sectionsSpace: 2,
//               centerSpaceRadius: 75,
//               sections: showingSections(),
//             ),
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.only(
//             top: 45,
//             left: 50,
//           ),
//           child: const Column(
//             children: [
//               Text(
//                 '23',
//                 style: TextStyle(
//                   height: 0,
//                   fontSize: 50,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//                   Text(
//                 'Totaal aantal\nvragen',
//                 style: TextStyle(
//                   height: 0,
//                   fontSize: 16,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   List<PieChartSectionData> showingSections() {
//     return [
//       PieChartSectionData(
//         color: Colors.red,
//         value: 8,
//         title: '',
//         radius: 5,
//       ),
//       PieChartSectionData(
//         color: Colors.orange,
//         value: 7,
//         title: '',
//         radius: 5,
//       ),
//       PieChartSectionData(
//         color: Colors.green,
//         value: 8,
//         title: '',
//         radius: 5,
//       ),
//     ];
//   }
// }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 180,
              width: 180,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 55,
                  sections: showingSections(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 52,
                left: 40,
              ),
              child: const Column(
                children: [
                  Text(
                    '23',
                    style: TextStyle(
                      height: 0,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Totaal aantal\nvragen',
                    style: TextStyle(
                      height: 0,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(padding: const EdgeInsets.only(top: 33),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: legendItems(),
        ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Colors.red,
        value: 8,
        title: '',
        radius: 5,
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 7,
        title: '',
        radius: 5,
      ),
      PieChartSectionData(
        color: Colors.green,
        value: 8,
        title: '',
        radius: 5,
      ),
    ];
  }

  List<Widget> legendItems() {
    return [
      const LegendItem(
          color: Color.fromARGB(255, 236, 12, 12), text: 'Openstaande vragen'),
      const SizedBox(
        height: 13,
      ),
      const LegendItem(
          color: Color.fromARGB(255, 255, 147, 4), text: 'In behandeling'),
           const SizedBox(
        height: 13,
      ),
      const LegendItem(color: primary, text: 'Afgehandeld'),
    ];
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          width: 4,
          height: 28,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(4)),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
