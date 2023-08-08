import 'package:flutter/material.dart';
import 'dart:ui';

class MenuOptions extends StatelessWidget {
  const MenuOptions({super.key});

  static const buttonSpacing = 8.0;
  static const buttonPadding = 12.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displayMedium;

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
              child: Padding(
                padding: const EdgeInsets.all(buttonPadding),
                child: Text(
                  'Melody Spark',
                  style: textStyle,
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: buttonSpacing),
          child: ElevatedButton(
              onPressed: () {
                print('Tuner');
              },
              child: Padding(
                padding: const EdgeInsets.all(buttonPadding),
                child: Text(
                  'Tuner',
                  style: textStyle,
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: buttonSpacing, bottom: 2 * buttonSpacing),
          child: ElevatedButton(
            onPressed: () {
              print('Learn the Fretboard');
            },
            child: Padding(
              padding: const EdgeInsets.all(buttonPadding),
              child: Text(
                'Learn The Fretboard',
                style: textStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
