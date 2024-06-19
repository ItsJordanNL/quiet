import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';
import 'package:quiet_app/screens/volunteer/components/dashboard-donutchart.dart';
import 'package:quiet_app/screens/volunteer/components/dashboard-questionlist.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            title: const Text("Hey Sarah, welke leden ga jij \nvandaag helpen?",
                style: TextStyle(
                    color: primaryText,
                    fontWeight: FontWeight.w700,
                    fontSize: 24)),
            backgroundColor: primary,
          ),
        ),
        body: const Stack(
          children:[DashboardDonutchart(),
          DashboardQuestionlist()],
        ));
  }
}
