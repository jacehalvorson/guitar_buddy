import 'fretboard.dart';
import 'dart:math';

NoteList noMarkedFrets = {
  0: [],
  1: [],
  2: [],
  3: [],
  4: [],
  5: [],
};

NoteList markedFrets1 = {
  0: [
    0,
    3,
    5,
    7,
    9,
    12,
  ],
  1: [
    1,
    4,
    6,
    8,
    10,
    13,
  ],
  2: [
    2,
    5,
    7,
    9,
    11,
    14,
  ],
  3: [
    3,
    6,
    8,
    10,
    12,
    15,
  ],
  4: [
    4,
    7,
    9,
    11,
    13,
    16,
  ],
  5: [
    5,
    8,
    10,
    12,
    14,
    17,
  ],
};

NoteList markedFrets2 = {
  0: [2],
  1: [],
  2: [],
  3: [],
  4: [],
  5: [],
};

// Generate a random integer between min and max (inclusive)
int randomInt(int min, int max) => Random().nextInt(max - min + 1) + min;
// Use randomInt function to display random notes
NoteList randomMarkedFrets = {
  for (int i = 0; i < 6; i++) i: List.generate(6, (_) => randomInt(0, 20)),
};
