import 'package:flutter/material.dart';

import 'fretboard.dart';
import 'marked_frets_samples.dart';

class MelodySpark extends StatefulWidget {
  const MelodySpark({Key? key}) : super(key: key);

  @override
  State<MelodySpark> createState() => _MelodySparkState();
}

class _MelodySparkState extends State<MelodySpark> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).colorScheme.secondary,
      child: Center(child: Fretboard(markedFrets: noMarkedFrets)),
    );
  }
}
