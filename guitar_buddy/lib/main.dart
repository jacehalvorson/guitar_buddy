import 'package:flutter/material.dart';
import 'dart:ui';

import 'menu.dart';
import 'settings.dart';
import 'types.dart';
import 'melody_spark.dart';
import 'menu_background.dart';
import 'utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guitar Buddy',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color.fromRGBO(20, 20, 20, 1),
          secondary: Color.fromARGB(255, 31, 131, 212),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Guitar Buddy'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppState _currentAppState = AppState.menu;

  void _changeAppState(AppState newState) {
    setState(() {
      _currentAppState = newState;
      print('New state: $_currentAppState');
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final settingsHeight = screenHeight * 0.75;
    final settingsWidth = screenWidth * 0.75;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Stack(children: [
        // In the menu or settings states, show the menu options and background
        if (_currentAppState == AppState.menu ||
            _currentAppState == AppState.settings) ...[
          // const Text('Hello world!'),
          const MenuBackground(),
          Center(
            child: Menu(changeAppStateCallback: _changeAppState),
          ),
        ],

        // In the settings state, blur the entire screen with an opacity
        // transition stacked on the menu options
        AnimatedOpacity(
          opacity: (_currentAppState == AppState.settings) ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: (_currentAppState == AppState.settings)
              ? const BlurredOverlay()
              : const IgnorePointer(
                  child: BlurredOverlay(),
                ),
        ),

        // In the settings state, open settings page
        AnimatedPositioned(
          top: (_currentAppState == AppState.settings)
              ? (screenHeight / 2 - settingsHeight / 2)
              : screenHeight,
          left: (screenWidth / 2 - settingsWidth / 2),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: Settings(
            height: settingsHeight,
            width: settingsWidth,
            closeCallback: () {
              _changeAppState(AppState.menu);
            },
          ),
        ),

        // In the melody spark state, show the melody spark page
        if (_currentAppState == AppState.melodySpark)
          const Center(
            child: MelodySpark(),
          ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _changeAppState(AppState.settings);
        },
        tooltip: 'Settings',
        backgroundColor: colorScheme.secondary,
        child: const Icon(Icons.settings),
      ),
    );
  }
}
