import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  final String title = 'Settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('1'),
          Text('2'),
          Text('3'),
        ],
      ),
    );
  }
}
