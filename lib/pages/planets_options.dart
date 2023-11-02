import 'package:flutter/material.dart';
import 'Planet_system_page.dart';
import '../model/planet.dart';

class PlanetsOptions extends StatefulWidget {
  final List<String> radius;
  final List<String> remoteness;
  final List<String> speed;
  final List<String> color;
  PlanetsOptions({
    super.key,
    required this.radius,
    required this.remoteness,
    required this.speed,
    required this.color,
  });

  @override
  State<PlanetsOptions> createState() => _PlanetsOptionsState(
        radius: radius,
        remoteness: remoteness,
        speed: speed,
        color: color,
      );
}

class _PlanetsOptionsState extends State<PlanetsOptions> {
  final List<String> radius;
  final List<String> remoteness;
  final List<String> speed;
  final List<String> color;
  _PlanetsOptionsState({
    required this.radius,
    required this.remoteness,
    required this.speed,
    required this.color,
  });

  final _formKey = GlobalKey<FormState>();
  final _radiusController = TextEditingController();
  final _remotenessController = TextEditingController();
  final _speedController = TextEditingController();
  final _colorController = TextEditingController();

  Planet newPlanet = Planet(color: '', radius: '', remoteness: '', speed: '');

  @override
  void dispose() {
    _radiusController.dispose();
    _remotenessController.dispose();
    _speedController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const SizedBox(height: 30),
            TextFormField(
              controller: _radiusController,
              decoration: const InputDecoration(
                labelText: "Radius",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              validator: _validateRadius,
              maxLength: 2,
              keyboardType: TextInputType.number,
              onSaved: (value) {
                newPlanet.radius = value!;
                radius.add(value);
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _remotenessController,
              decoration: const InputDecoration(
                labelText: "Remoteness",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              validator: _validateRemoteness,
              maxLength: 2,
              keyboardType: TextInputType.number,
              onSaved: (value) {
                newPlanet.remoteness = value!;
                remoteness.add(value);
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _speedController,
              decoration: const InputDecoration(
                labelText: "Speed",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              validator: _validateSpeed,
              maxLength: 2,
              keyboardType: TextInputType.number,
              onSaved: (value) {
                newPlanet.speed = value!;
                speed.add(value);
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _colorController,
              decoration: const InputDecoration(
                labelText: "Color",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              validator: _validateColor,
              onSaved: (value) {
                newPlanet.color = value!;
                color.add(value);
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: const Text('Add planet to system'),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateRadius(String? value) {
    if (value == null) {
      return 'Radius cannot be empty';
    } else if ((int.parse(_radiusController.text) > 10) ||
        (int.parse(_radiusController.text) < 1)) {
      return 'Radius should be > 0 and < 11';
    } else {
      return null;
    }
  }

  String? _validateRemoteness(String? value) {
    if (value == null) {
      return 'Remoteness cannot be empty';
    } else if ((int.parse(_remotenessController.text) > 10) ||
        (int.parse(_remotenessController.text) < 3)) {
      return 'Remoteness should be > 2 and < 11';
    } else {
      return null;
    }
  }

  String? _validateSpeed(String? value) {
    if (value == null) {
      return 'Speed cannot be empty';
    } else if ((int.parse(_speedController.text) > 10) ||
        (int.parse(_speedController.text) < 1)) {
      return 'Speed should be > 0 and < 11';
    } else {
      return null;
    }
  }

  String? _validateColor(String? value) {
    if (value == null) {
      return 'Color cannot be empty';
    } else if (!(_colorController.text == "green") &
        !(_colorController.text == "red") &
        !(_colorController.text == "blue")) {
      return 'Enter Green, Red or Blue';
    } else {
      return null;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(radius);
      print(remoteness);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlanetSystemPage(
                  radius: radius,
                  remoteness: remoteness,
                  speed: speed,
                  color: color,
                )),
      );
    } else {
      _showMessage(message: 'Form is not valid! Please review and correct');
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
