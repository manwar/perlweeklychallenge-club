// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause

import 'package:pwc_312/ch_1.dart' show LETTERS, OFFSET, distance, typing_time;
import 'package:test/test.dart' show test;

const TEST_OFFSET_DATA = [
  ("a", 0),
  ("y", LETTERS - 2),
  ("C", null),
];

const TEST_DISTANCE_DATA = [
  ("a", "a", false),
  ("a", "b", false),
  ("b", "a", true),
  ("a", "m", false),
  ("m", "a", true),
  ("a", "n", true),
  ("n", "a", true),
];

const TEST_SINGLE_LETTER_DATA = [
  ("a", true, false),
  ("b", true, false),
  ("m", true, false),
  ("n", true, true),
  ("o", false, true),
  ("z", false, true),
];

const TEST_WORD_DATA = [
  ("", 0),
  ("aaa", 3),
  ("abc", 5),
  ("bza", 7),
  ("zjpc", 34),
];

void _testOffset() {
  test("ch_1.offset.letters", () {
    assert(LETTERS == "z".codeUnits[0] - "a".codeUnits[0] + 1);
  });

  for (final tcase in TEST_OFFSET_DATA) {
    final (letter, expected) = tcase;
    test("ch_1.offset.$letter", () {
      assert(OFFSET[letter] == expected);
    });
  }
}

int _calc_distance_clockwise(String lfrom, String lto) {
  final offset_from = OFFSET[lfrom]!;
  final offset_to = OFFSET[lto]!;
  if (offset_from <= offset_to) {
    return offset_to - offset_from;
  } else {
    return LETTERS - (offset_from - offset_to);
  }
}

int _calc_distance_counterclockwise(String lfrom, String lto) {
  return lfrom == lto ? 0 : LETTERS - _calc_distance_clockwise(lfrom, lto);
}

void _testDistance() {
  for (final tcase in TEST_DISTANCE_DATA) {
    final (lfrom, lto, counter) = tcase;
    test("ch_1.distance.$lfrom.$lto", () {
      if (counter) {
        assert(distance(lfrom, lto) ==
            _calc_distance_counterclockwise(lfrom, lto));
      } else {
        assert(distance(lfrom, lto) == _calc_distance_clockwise(lfrom, lto));
      }
    });
  }
}

void _testTimeSingleLetter() {
  for (final tcase in TEST_SINGLE_LETTER_DATA) {
    final (letter, clockwise, counterclockwise) = tcase;
    test("ch_1.single_letter.$letter", () {
      final exp_clockwise = 1 + OFFSET[letter]!;
      final exp_counterclockwise = 1 + LETTERS - OFFSET[letter]!;
      assert((typing_time(letter) == exp_clockwise) == clockwise);
      assert((typing_time(letter) == exp_counterclockwise) == counterclockwise);
    });
  }
}

void _testTimeWord() {
  for (final tcase in TEST_WORD_DATA) {
    final (word, expected) = tcase;
    test("ch_1.word.$word", () {
      assert(typing_time(word) == expected);
    });
  }
}

/// Run the tests for the Minimum Time implementation.
void main() {
  _testOffset();
  _testDistance();
  _testTimeSingleLetter();
  _testTimeWord();
}
