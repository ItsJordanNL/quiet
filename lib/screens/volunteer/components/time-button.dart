import 'package:flutter/material.dart';
import 'package:quiet_app/constants/constants.dart';

class SortingButton extends StatelessWidget {
  final bool sortByNewest;
  final Function() onPressed;

  SortingButton({required this.sortByNewest, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(10.0),
          backgroundColor: primary,
        ),
        child: const Icon(
          Icons.timelapse,
          color: Colors.white,
          size: 20.0,
        ),
      ),
    );
  }
}
