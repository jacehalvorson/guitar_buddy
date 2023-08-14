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
    final fretboardHeight = screenHeight * 0.9;
    final fretboardWidth = screenWidth * 0.6;

    // Length from nut to saddle
    final scaleLength = fretboardHeight * 1.23;
    // Fret division factor
    const fdiv = 17.817;
    const numFrets = 23;

    final List<double> fretWidths =
        calculateFretWidths(scaleLength, fdiv, numFrets);

    return Container(
      width: fretboardWidth,
      height: fretboardHeight,
      color: Theme.of(context).colorScheme.primary,
      child: Center(
        child: Stack(
          children: [
            // Fret lines
            Column(
              children: List.generate(numFrets + 1, (index) {
                return Padding(
                    padding: (index < numFrets)
                        ? EdgeInsets.only(bottom: fretWidths[index])
                        : EdgeInsets.zero,
                    child: Container(
                        height: 2,
                        width: fretboardWidth,
                        color: Colors.grey[800]));
              }),
            ),

            // Strings
            Row(
              children: List.generate(6, (index) {
                return Padding(
                    padding: EdgeInsets.only(left: fretboardWidth / 7.2),
                    child: Container(
                      height: fretboardHeight,
                      width: 2,
                      color: Colors.white,
                    ));
              }),
            ),
          ],
        ),
      ),
    );
  }
}

List<double> calculateFretWidths(
    double scaleLength, double fdiv, int numFrets) {
  // Width of first fret https://archive.siam.org/careers/pdf/guitar.pdf
  double previousFretPosition = scaleLength / fdiv;

  final fretWidths = <double>[previousFretPosition];

  for (var i = 1; i < numFrets; i++) {
    var fretPosition =
        ((scaleLength - previousFretPosition) / fdiv) + previousFretPosition;
    var fretWidth = fretPosition - previousFretPosition;

    fretWidths.add(fretWidth);
    previousFretPosition = fretPosition;
  }

  print(fretWidths);
  return fretWidths;
}
