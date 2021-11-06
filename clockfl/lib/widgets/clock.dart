import 'dart:async';
import 'package:clockfl/utils/colors.dart';
import 'package:clockfl/widgets/painter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  final format = NumberFormat("00");

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 50),
          child: Text(
              format.format(now.hour).toString() +
                  ":" +
                  format.format(now.minute).toString() +
                  ":" +
                  format.format(now.second).toString(),
              style: const TextStyle(
                letterSpacing: 10,
                fontStyle: FontStyle.italic,
                color: Color(0xffff8800),
                fontSize: 40,
              )),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.width * 0.95,
          child: CustomPaint(painter: Painter()),
        ),
        Column(
          children: [
            Text("D   E   S   I   G   N   E   D     B   Y",
                style: TextStyle(color: watchColor)),
            Image(
              image: const AssetImage("assets/assinatura.png"),
              width: MediaQuery.of(context).size.width * 0.5,
            )
          ],
        )
      ],
    );
  }
}
