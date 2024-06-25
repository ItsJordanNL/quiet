import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quiet_app/constants/constants.dart';


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
                        '6',
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
      ]),
    );
  }

// Colors and value donut chart
  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: unanswered,
        value: 2,
        title: '',
        radius: 5,
      ),
      PieChartSectionData(
        color: inprogress,
        value: 3,
        title: '',
        radius: 5,
      ),
      PieChartSectionData(
        color: primary,
        value: 1,
        title: '',
        radius: 5,
      ),
    ];
  }

// Legend items
  List<Widget> legendItems() {
    return [
      const LegendItem(color: unanswered, text: '3 Openstaande vragen'),
      const SizedBox(
        height: 13,
      ),
      const LegendItem(color: inprogress, text: '2 In behandeling'),
      const SizedBox(
        height: 13,
      ),
      const LegendItem(color: primary, text: '1 Afgehandeld'),
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
