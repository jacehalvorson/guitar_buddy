import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: const Column(
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
