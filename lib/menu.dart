import 'package:flutter/material.dart';
import 'types.dart';

class Menu extends StatelessWidget {
  const Menu({super.key, required this.changeAppStateCallback});

  final void Function(AppState) changeAppStateCallback;

  static const buttonSpacing = 8.0;
  static const buttonPadding = 12.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    final buttonStyle = ElevatedButton.styleFrom(
        backgroundColor: colorScheme.onPrimary,
        textStyle: theme.textTheme.displaySmall,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(buttonPadding),
        minimumSize: Size(screenWidth * 0.8, 0));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Title
        Padding(
          padding: const EdgeInsets.only(bottom: buttonSpacing * 10),
          child: Text(
            "Guitar Buddy",
            style: theme.textTheme.displayLarge!.copyWith(
              color: colorScheme.secondary,
              fontFamily: 'Georgia', // Set the font family
            ),
          ),
        ),

        // Buttons
        Padding(
            padding: const EdgeInsets.only(
                top: buttonSpacing, bottom: 2 * buttonSpacing),
            child: ElevatedButton(
              onPressed: () {
                changeAppStateCallback(AppState.melodySpark);
              },
              style: buttonStyle,
              child: const Padding(
                padding: EdgeInsets.all(buttonPadding),
                child: Text(
                  'Melody Spark',
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: buttonSpacing),
          child: ElevatedButton(
              onPressed: () {
                changeAppStateCallback(AppState.tuner);
              },
              style: buttonStyle,
              child: const Padding(
                padding: EdgeInsets.all(buttonPadding),
                child: Text(
                  'Tuner',
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: buttonSpacing, bottom: 2 * buttonSpacing),
          child: ElevatedButton(
            onPressed: () {
              changeAppStateCallback(AppState.learnTheFretboard);
            },
            style: buttonStyle,
            child: const Padding(
              padding: EdgeInsets.all(buttonPadding),
              child: Text(
                'Learn The Fretboard',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
