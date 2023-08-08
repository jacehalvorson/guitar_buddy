import 'package:flutter/material.dart';
import 'dart:ui';

import 'menu_options.dart';
import 'settings.dart';
import 'types.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade300),
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

  void _openSettings() {
    setState(() {
      // Grey out everything and open settings
      (_currentAppState == AppState.settings)
          ? _currentAppState = AppState.menu
          : _currentAppState = AppState.settings;
      print(_currentAppState);
    });
  }

  void _launchMelodySpark() {
    setState(() {
      // Switch states to Melody Spark
    });
  }

  void _launchTuner() {
    setState(() {
      // Switch states to Tuner
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Stack(children: [
        // In the menu or settings states, show the menu options
        if (_currentAppState == AppState.menu ||
            _currentAppState == AppState.settings) ...[
          const Center(
            child: MenuOptions(),
          ),
        ],

        // In the settings state, blur the entire screen and open settings page
        if (_currentAppState == AppState.settings) ...[
          const BlurredOverlay(),
          const Center(
            child: Settings(),
          ),
        ]
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _openSettings,
        tooltip: 'Settings',
        child: const Icon(Icons.settings),
      ),
    );
  }
}

class BlurredOverlay extends StatelessWidget {
  const BlurredOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter:
          ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Adjust blur intensity
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent, // Color with reduced opacity
      ),
    );
  }
}
