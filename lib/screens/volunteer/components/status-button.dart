import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';

class StatusButton extends StatelessWidget {
  final Function() onPressed;

  const StatusButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10.0),
          backgroundColor: primary // Customize button color
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 20.0,
        ),
      ),
    );
  }
}
