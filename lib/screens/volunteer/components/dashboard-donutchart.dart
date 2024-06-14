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
      margin: const EdgeInsets.all(20),
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
        // question title and filter button
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Vragen van Leden',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
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
                  )),
            ],
          ),
        ),
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

        // ticket

        Card(
            child: Row(children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(30),
                    child: Image.asset('assets/images/member_truus.png',
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Truus Bekker',
                  style: TextStyle(fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 0),
            width: 244,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Opacity(
                        opacity: 0.85,
                        child: Text('3-6-2024'),
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                            color: primary, shape: BoxShape.circle),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        'Voetbalwedstrijd PSV-Ajax # 1',
                        style: TextStyle(
                            fontSize: 15.5, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Row(children: [
                  Opacity(
                    opacity: 0.5,
                    child: Icon(Icons.person_outline_rounded),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Text(
                      'Sarah',
                      style:TextStyle(fontSize: 16),
                    ),
                  ),
                ]),
              ],
            ),
          )
        ])),
      ]),
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


