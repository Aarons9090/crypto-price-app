import 'package:flutter/material.dart';

import '../main.dart';

class TimeRangeButton extends StatelessWidget {
  final String title;
  final Function onPressFunc;
  const TimeRangeButton(this.title, this.onPressFunc, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: FloatingActionButton.extended(
          backgroundColor: AppColors().dark_purple,
          splashColor: AppColors().pink,
          extendedPadding: const EdgeInsets.all(30),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          label: Text(title, style: TextStyle(color: AppColors().pink)),
          onPressed: () {
            onPressFunc;
          }),
    );
  }
}
