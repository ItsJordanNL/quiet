import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quiet_app/constants/constants.dart';

class DashboardTickets extends StatefulWidget {
  const DashboardTickets({super.key});

  @override
  State<DashboardTickets> createState() => _DashboardTicketsState();
}

class _DashboardTicketsState extends State<DashboardTickets> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            // donut chart
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
            // Text in donut chart
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
        // legend
        Padding(
          padding: const EdgeInsets.only(top: 33),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: legendItems(),
          ),
        ),
      ],
    );
  }

// Colors and value donut chart
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

// Legend items
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
