import 'package:flutter/material.dart';

class MenuOptions extends StatelessWidget {
  static const buttonSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(
                top: buttonSpacing, bottom: 2 * buttonSpacing),
            child: ElevatedButton(
              onPressed: () {
                print('Melody Spark');
              },
              child: const Text('Melody Spark'),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: buttonSpacing),
          child: ElevatedButton(
            onPressed: () {
              print('Tuner');
            },
            child: const Text('Tuner'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: buttonSpacing, bottom: 2 * buttonSpacing),
          child: ElevatedButton(
            onPressed: () {
              print('Learn the Fretboard');
            },
            child: const Text('Learn the Fretboard'),
          ),
        ),
      ],
    );
  }
}
