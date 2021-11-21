import 'dart:async';

import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:flutter/material.dart';

class StartTimeWidget extends StatefulWidget {
  final DateTime startTime;
  const StartTimeWidget({Key? key, required this.startTime}) : super(key: key);

  @override
  _StartTimeWidgetState createState() => _StartTimeWidgetState();
}

class _StartTimeWidgetState extends State<StartTimeWidget> {


  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    _seconds = DateTime.now().difference(widget.startTime).inSeconds.abs();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        setState(() {
          _seconds++;
        });
      },
    );
    super.initState();
  }



  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text("Нийт: ${(_seconds~/60).toString().padLeft(2, "0")}:${(_seconds%60).toString().padLeft(2, "0")}", style: AppStyle.textSubtitle2.copyWith(color: AppColors.textColor),);
  }
}
