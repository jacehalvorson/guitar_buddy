import 'package:flutter/material.dart';

const NUM_FRETS = 23;
const FDIV = 17.817;
const FRET_MARKER_DIAMETER = 20.0;
const FRET_LINE_HEIGHT = 2;

// Holds the "marked frets" for each string.
// These will be used to display notes on the fretboard.
typedef NoteList = Map<int, List<int>>;

final NoteList noteLists = {
  0: [], // E
  1: [], // A
  2: [], // D
  3: [], // G
  4: [], // B
  5: [], // e
};

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
  final double firstFretPosition = scaleLength / fdiv;
  double previousFretPosition = firstFretPosition;
  double fretPosition;
  double fretWidth;

  List<double> fretWidths = [0, firstFretPosition];

  for (int fretNumber = 2; fretNumber < numFrets; fretNumber++) {
    fretPosition =
        ((scaleLength - previousFretPosition) / fdiv) + previousFretPosition;
    fretWidth = fretPosition - previousFretPosition;

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
      children: List.generate(NUM_FRETS, (index) {
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
    // Calculate the horizontal padding for strings (half the distance between)
    double stringPadding = widget.fretboardWidth / 14.6;

    // Get the absolute distance from nut of each fret using fretWidths
    List<double> fretPositions = [0];
    for (int fretNumber = 1;
        fretNumber < widget.fretWidths.length;
        fretNumber++) {
      double fretWidth = widget.fretWidths[fretNumber];
      fretPositions
          .add(fretWidth + fretPositions[fretNumber - 1] + FRET_LINE_HEIGHT);
    }

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: stringPadding),
        child: Row(
          // For each string
          children: List.generate(6, (stringIndex) {
            return Stack(children: [
              // String
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: stringPadding),
                  child: Container(
                    height: widget.fretboardHeight,
                    width: 2,
                    color: Colors.white,
                  )),

              // For Each note on the string
              ...List.generate(widget.markedFrets[stringIndex]!.length,
                  (markedFretIndex) {
                // Select string based on markedFretIndex
                final int fretNumber =
                    widget.markedFrets[stringIndex]![markedFretIndex];

                // Calculate offsets to position icon from its middle rather
                // than from its edge
                const double noteMidpointOffset = FRET_MARKER_DIAMETER / 2;
                final double fretMidpointOffset =
                    widget.fretWidths[fretNumber] / 2;

                // Spacing from the nut to the icon for this fret number
                final double noteDistanceFromTop = fretPositions[fretNumber] -
                    noteMidpointOffset -
                    fretMidpointOffset;

                // Spacing from left of neck based on which string
                final double noteDistanceFromLeft = (stringPadding) +
                    ((stringPadding * stringIndex) / 128) -
                    noteMidpointOffset;

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
