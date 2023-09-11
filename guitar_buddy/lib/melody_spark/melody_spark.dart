import 'package:flutter/material.dart';

import 'fretboard.dart';
import 'marked_frets_samples.dart';
import '../utils.dart';

class MelodySpark extends StatefulWidget {
  const MelodySpark({Key? key, required this.closeCallback}) : super(key: key);

  final void Function() closeCallback;

  @override
  State<MelodySpark> createState() => _MelodySparkState();
}

class _MelodySparkState extends State<MelodySpark> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // This secondary stack is only to expand the fretboard to the full screen
      Stack(fit: StackFit.expand, children: [
        // Melody Spark fretboard
        Center(child: Fretboard(markedFrets: noMarkedFrets)),
      ]),

      // Exit button, pass down close callback
      Padding(
          padding: const EdgeInsets.all(10),
          child: BackToHome(onPressedCallback: widget.closeCallback)),
    ]);
  }
}
