import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';

class DashboardQuestionFilter extends StatefulWidget {
  const DashboardQuestionFilter({super.key});

  @override
  State<DashboardQuestionFilter> createState() =>
      _DashboardQuestionFilterState();
}

class _DashboardQuestionFilterState extends State<DashboardQuestionFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
