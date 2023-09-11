import 'package:flutter/material.dart';

const NUM_FRETS = 23;
const FDIV = 17.817;

// Holds the "marked frets" for each string.
// These will be used to display notes on the fretboard.
class NoteList {
  List<int> E = [];
  List<int> A = [];
  List<int> D = [];
  List<int> G = [];
  List<int> B = [];
  List<int> e = [];

  NoteList(
      {required this.E,
      required this.A,
      required this.D,
      required this.G,
      required this.B,
      required this.e});
}

class Fretboard extends StatefulWidget {
  const Fretboard({Key? key, required this.markedFrets}) : super(key: key);

  final NoteList markedFrets;

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

    final List<double> fretWidths =
        calculateFretWidths(scaleLength, FDIV, NUM_FRETS);

    return Container(
        width: fretboardWidth,
        height: fretboardHeight,
        color: Theme.of(context).colorScheme.primary,
        child: Center(
            child: Stack(children: [
          // Fret lines
          FretLines(fretWidths: fretWidths, fretboardWidth: fretboardWidth),

          // Strings
          GuitarStrings(
            markedFrets: widget.markedFrets,
            fretboardHeight: fretboardHeight,
            fretboardWidth: fretboardWidth,
            fretWidths: fretWidths,
          ),
        ])));
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

  return fretWidths;
}

class FretLines extends StatelessWidget {
  const FretLines(
      {Key? key, required this.fretboardWidth, required this.fretWidths})
      : super(key: key);

  final double fretboardWidth;
  final List<double> fretWidths;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(NUM_FRETS + 1, (index) {
        return Padding(
            padding: (index < NUM_FRETS)
                ? EdgeInsets.only(bottom: fretWidths[index])
                : EdgeInsets.zero,
            child: Container(
                height: 2, width: fretboardWidth, color: Colors.grey[800]));
      }),
    );
  }
}

class GuitarStrings extends StatefulWidget {
  const GuitarStrings(
      {Key? key,
      required this.markedFrets,
      required this.fretboardHeight,
      required this.fretboardWidth,
      required this.fretWidths})
      : super(key: key);

  final NoteList markedFrets;
  final double fretboardWidth;
  final double fretboardHeight;
  final List<double> fretWidths;

  @override
  State<GuitarStrings> createState() => _GuitarStringsState();
}

class _GuitarStringsState extends State<GuitarStrings> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(6, (index) {
        return Padding(
            padding: EdgeInsets.only(left: widget.fretboardWidth / 7.2),
            child: Container(
              height: widget.fretboardHeight,
              width: 2,
              color: Colors.white,
            ));
      }),
    );
  }
}
