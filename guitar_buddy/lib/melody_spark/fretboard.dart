import 'package:flutter/material.dart';

const NUM_FRETS = 23;
const FDIV = 17.817;
const FRET_MARKER_DIAMETER = 20.0;
const FRET_LINE_HEIGHT = 2;

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

  List<double> fretWidths = [0, previousFretPosition];

  for (int fretNumber = 1; fretNumber < numFrets; fretNumber++) {
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
            padding: EdgeInsets.only(top: fretWidths[index]),
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
    // Print the marked frets for each string
    print('E: ${widget.markedFrets.E}');
    print('A: ${widget.markedFrets.A}');
    print('D: ${widget.markedFrets.D}');
    print('G: ${widget.markedFrets.G}');
    print('B: ${widget.markedFrets.B}');
    print('e: ${widget.markedFrets.e}');

    double distanceBetweenStrings = widget.fretboardWidth / 7.3;

    // Get the absolute distance from nut of each fret using fretWidths
    List<double> fretPositions = [0];
    widget.fretWidths.forEach((element) {
      final index = widget.fretWidths.indexOf(element);

      if (index > 0) {
        fretPositions
            .add(element + fretPositions[index - 1] + FRET_LINE_HEIGHT);
      }
    });
    print('fretPositions: $fretPositions');
    print('fretWidths: ${widget.fretWidths}');

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: distanceBetweenStrings / 2),
        child: Row(
          children: List.generate(6, (index) {
            return Stack(children: [
              // String
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: distanceBetweenStrings / 2),
                  child: Container(
                    height: widget.fretboardHeight,
                    width: 2,
                    color: Colors.white,
                  )),

              // For Each note on the string
              ...List.generate(widget.markedFrets.E.length, (index) {
                final int fretNumber = widget.markedFrets.E[index];

                // Calculate offsets to position icon from its middle rather than edge
                const double noteMidpointOffset = FRET_MARKER_DIAMETER / 2;
                final double fretMidpointOffset =
                    widget.fretWidths[fretNumber] / 2;

                // Spacing from the nut to the icon for this fret number
                final double noteDistanceFromTop = fretPositions[fretNumber] -
                    noteMidpointOffset -
                    fretMidpointOffset;

                // TODO adjust based on which string is current
                final double noteDistanceFromLeft =
                    distanceBetweenStrings / 2 - noteMidpointOffset;

                return Positioned(
                    top: noteDistanceFromTop,
                    left: noteDistanceFromLeft,
                    child: Container(
                        height: FRET_MARKER_DIAMETER,
                        width: FRET_MARKER_DIAMETER,
                        decoration: BoxDecoration(
                            color: Colors.amber.shade700,
                            borderRadius:
                                BorderRadius.circular(noteMidpointOffset))));
              }),
            ]);
          }),
        ));
  }
}
