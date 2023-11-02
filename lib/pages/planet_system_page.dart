import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'planets_options.dart';
import '../model/planet.dart';
import '../widgets/planet_widget.dart';

class PlanetSystemPage extends StatelessWidget {
  final List<String> radius;
  final List<String> remoteness;
  final List<String> speed;
  final List<String> color;
  PlanetSystemPage({
    super.key,
    required this.radius,
    required this.remoteness,
    required this.speed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Planet system",
      home: Scaffold(
        body: Center(
          child: AnimatedPlanets(
            radius: radius,
            remoteness: remoteness,
            speed: speed,
            color: color,
          ),
        ),
      ),
    );
  }
}

class AnimatedPlanets extends StatefulWidget {
  final List<String> radius;
  final List<String> remoteness;
  final List<String> speed;
  final List<String> color;
  const AnimatedPlanets(
      {super.key,
      required this.radius,
      required this.remoteness,
      required this.speed,
      required this.color});

  @override
  State<AnimatedPlanets> createState() => _AnimatedPlanetsState(
        radius: radius,
        remoteness: remoteness,
        speed: speed,
        color: color,
      );
}

class _AnimatedPlanetsState extends State<AnimatedPlanets> {
  final List<String> radius;
  final List<String> remoteness;
  final List<String> speed;
  final List<String> color;
  _AnimatedPlanetsState(
      {required this.radius,
      required this.remoteness,
      required this.speed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    print(radius);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Container(
              width:200,
              height:200,
              alignment: FractionalOffset.bottomCenter,
              margin: EdgeInsets.only(top:270, left: 90),
              child: ListView.builder(
                itemCount: radius.length,
                itemBuilder: (BuildContext context, int index) {
                  print("index: $index");
                  return Container(
                    width: 40,
                    height: 40,
                    child: Stack(
                      children: [
                        PlanetWidget(
                          radius: radius[index],
                          remoteness: remoteness[index],
                          speed: speed[index],
                          color: color[index],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.yellow),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlanetsOptions(
                        radius: radius,
                        remoteness: remoteness,
                        speed: speed,
                        color: color,
                      ),
                    ),
                  );
                },
                child: const Text("Добавить планеты в солнечную систему"),
              ),
            ),
          ],
        );
      },
    );
  }
}
