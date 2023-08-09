import 'package:flutter/material.dart';

class Fretboard extends StatefulWidget {
  const Fretboard({Key? key}) : super(key: key);

  @override
  State<Fretboard> createState() => _FretboardState();
}

class _FretboardState extends State<Fretboard> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.6,
      height: screenHeight * 0.9,
      color: Theme.of(context).colorScheme.primary,
      child: const Center(child: Text('Fretboard')),
    );
  }
}
