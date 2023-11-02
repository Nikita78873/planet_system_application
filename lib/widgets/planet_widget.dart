import 'package:flutter/material.dart';
import 'dart:math' as math;

class PlanetWidget extends StatefulWidget {
  final String radius;
  final String remoteness;
  final String speed;
  final String color;
  const PlanetWidget(
      {super.key,
      required this.radius,
      required this.remoteness,
      required this.speed,
      required this.color});

  @override
  State<PlanetWidget> createState() => _PlanetWidgetState(
        radius: radius,
        remoteness: remoteness,
        speed: speed,
        color: color,
      );
}

class _PlanetWidgetState extends State<PlanetWidget>
    with SingleTickerProviderStateMixin {
  final String radius;
  final String remoteness;
  final String speed;
  final String color;

  _PlanetWidgetState(
      {required this.radius,
      required this.remoteness,
      required this.speed,
      required this.color});

  late AnimationController _controller;
  var parentWidth;
  var parentHeight;
  var endOffset;
  var startOffset;
  var dx, dy;
  var myColor;
  var speedvalue;
  double f = 0;

  @override
  void initState() {
    super.initState();

    speedvalue = ((5 / (int.parse(speed))) * 1000).ceil();

    _controller = AnimationController(
      duration: Duration(milliseconds: speedvalue),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
    _controller.repeat();
    print(_controller.duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 30, top: 30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomCenter,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            int childHeight = 2 * int.parse(radius);
            int childWidth = 2 * int.parse(radius);
            print(speedvalue);

            if (f == 0) {
              parentWidth = constraints.maxWidth;
              parentHeight = constraints.maxHeight;
              startOffset = const Offset(0, 0);
            } else {
              parentWidth = dx;
              parentHeight = dy;
              startOffset = endOffset;
            }

            if (color == "blue") {
              myColor = Colors.blue;
            }

            if (color == "red") {
              myColor = Colors.red;
            }

            if (color == "green") {
              myColor = Colors.green;
            }

            dx = (parentWidth - childWidth) / childWidth;
            dy = (parentHeight - childHeight) / childHeight;
            endOffset = Offset(
              getXCoord(
                dx,
                int.parse(radius),
                int.parse(remoteness),
              ),
              getYCoord(
                dy,
                int.parse(radius),
                int.parse(remoteness),
              ),
            );

            final offsetAnimation =
                Tween<Offset>(begin: startOffset, end: endOffset)
                    .animate(_controller);

            return SlideTransition(
                position: offsetAnimation,
                child: Container(
                  width: childWidth.toDouble(),
                  height: childHeight.toDouble(),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: myColor),
                ));
          },
        ),
      ),
    );
  }

  double getXCoord(dx, radius, remoteness) {
    var s = 2 * math.pi / 180;
    f = f + s;

    dx = 100 * math.sin(f) / 5 / (radius / 4) * (remoteness / 9);
    return dx;
  }

  double getYCoord(dy, radius, remoteness) {
    var s = 2 * math.pi / 180;
    f = f + s;

    dy = 100 * math.cos(f) / 5 / (radius / 4) * (remoteness / 9);
    return dy;
  }
}
