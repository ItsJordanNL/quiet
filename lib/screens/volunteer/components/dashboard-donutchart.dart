import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quiet_app/constants/constants.dart';
import 'package:quiet_app/screens/volunteer/components/dashboard-question_filter.dart';


class DashboardDonutchart extends StatefulWidget {
  const DashboardDonutchart({super.key});

  @override
  State<DashboardDonutchart> createState() => _DashboardDonutchartState();
}

class _DashboardDonutchartState extends State<DashboardDonutchart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                // donut chart
                SizedBox(
                  height: 120,
                  width: 115,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 55,
                      sections: showingSections(),
                    ),
                  ),
                ),
                // Text in donut chart
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    left: 7,
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
            // legend
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: legendItems(),
            ),
          ],
        ),
        const DashboardQuestionFilter()
        // question title and filter button
        // Container(
        //   margin: const EdgeInsets.only(top: 20, bottom: 10),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const Text(
        //         'Vragen van Leden',
        //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(
        //           width: 40,
        //           height: 40,
        //           child: ElevatedButton(
        //             onPressed: () {},
        //             style: ElevatedButton.styleFrom(
        //               shape: const CircleBorder(),
        //               padding: const EdgeInsets.all(10),
        //               backgroundColor: primary,
        //             ),
        //             child: const Icon(
        //               Icons.check,
        //               size: 20,
        //               color: backgroundColor,
        //             ),
        //           )),
        //     ],
        //   ),
        // ),
        // Container(
        //   margin: const EdgeInsets.only(bottom: 15),
        //   width: 96,
        //   height: 23,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     color: secondary,
        //   ),
        //   child: const Text(
        //     'juni',
        //     style: TextStyle(fontSize: 16),
        //     textAlign: TextAlign.center,
        //   ),
        // ),
      ]),
    );
  }



// Colors and value donut chart
  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: unanswered,
        value: 8,
        title: '',
        radius: 5,
      ),
      PieChartSectionData(
        color: inprogress,
        value: 7,
        title: '',
        radius: 5,
      ),
      PieChartSectionData(
        color: primary,
        value: 8,
        title: '',
        radius: 5,
      ),
    ];
  }

// Legend items
  List<Widget> legendItems() {
    return [
      const LegendItem(
          color: unanswered, text: 'Openstaande vragen'),
      const SizedBox(
        height: 13,
      ),
      const LegendItem(
          color: inprogress, text: 'In behandeling'),
      const SizedBox(
        height: 13,
      ),
      const LegendItem(color: primary, text: 'Afgehandeld'),
    ];
  }
}

// legend variables
class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({required this.color, required this.text});
// UI legend
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
