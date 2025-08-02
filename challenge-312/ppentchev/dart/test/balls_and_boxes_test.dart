// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause

import 'package:pwc_312/ch_2.dart' show Box, parse;
import 'package:test/test.dart' show test;

final TEST_DATA = [
  ("", 0, Map()),
  ("R3", 0, {3: Box(red: 1)}),
  (
    "G0B1R2R0B0",
    1,
    {
      0: Box(red: 1, green: 1, blue: 1),
      1: Box(blue: 1),
      2: Box(red: 1),
    },
  ),
  (
    "G1R3R6B3G6B1B6R1G3",
    3,
    {
      1: Box(red: 1, green: 1, blue: 1),
      3: Box(red: 1, green: 1, blue: 1),
      6: Box(red: 1, green: 1, blue: 1),
    },
  ),
  (
    "B3B2G1B3",
    0,
    {
      1: Box(green: 1),
      2: Box(blue: 1),
      3: Box(blue: 2),
    },
  ),
];

void _testParse() {
  for (final tcase in TEST_DATA) {
    final (word, _, boxes) = tcase;
    test("ch_2.parse.$word", () {
      final res = parse(word);

      // Sigh, apparently checking maps for equality is not implemented anywhere...
      for (final res_item in res.entries) {
        assert(boxes[res_item.key] == res_item.value);
      }
      for (final boxes_item in boxes.entries) {
        assert(res[boxes_item.key] == boxes_item.value);
      }
    });
  }
}

void _testCount() {
  for (final tcase in TEST_DATA) {
    final (word, expected, _) = tcase;
    test("ch_2.count.$word", () {
      final boxes = parse(word);
      final count = boxes.values.where((box) => box.isComplete).length;
      assert(count == expected);
    });
  }
}

/// Run the tests for the Minimum Time implementation.
void main() {
  _testParse();
  _testCount();
}
