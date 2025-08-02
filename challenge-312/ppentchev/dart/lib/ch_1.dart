// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause

import 'dart:math' show min;

import 'package:characters/characters.dart' show Characters;

/// The lowercase letters in the Latin alphabet.
const ALPHABET = "abcdefghijklmnopqrstuvwxyz";

/// The number of lowercase letters in the Latin alphabet.
const LETTERS = ALPHABET.length;

/// The ASCII code of the lowercase letter 'a'.
final _CODE_A = "a".codeUnits[0];

/// The offsets of the letters.
final Map<String, int> OFFSET = Map.fromEntries(Characters(ALPHABET)
    .map((chr) => MapEntry(chr, chr.codeUnits[0] - _CODE_A)));

int? distance(String lfrom, String lto) {
  final offset_from = OFFSET[lfrom];
  if (offset_from == null) {
    return null;
  }
  final offset_to = OFFSET[lto];
  if (offset_to == null) {
    return null;
  }
  final offset_abs = (offset_from - offset_to).abs();
  return min(offset_abs, LETTERS - offset_abs);
}

(String, int?) _typing_time_single((String, int?) acc, String next) {
  final (prev, res_prev) = acc;
  if (res_prev == null) {
    return (next, null);
  }
  final dist = distance(prev, next);
  if (dist == null) {
    return (next, null);
  }
  return (next, res_prev + 1 + dist);
}

int? typing_time(String word) {
  if (word.isEmpty) {
    return 0;
  }

  final List<String> letters = List.from(Characters(word));
  final first = letters.removeAt(0);
  final offset_first = distance("a", first);
  if (offset_first == null) {
    return null;
  }
  final res_first = 1 + offset_first;
  if (letters.isEmpty) {
    return res_first;
  }

  final (_, res) = letters.fold((first, res_first), _typing_time_single);
  return res;
}
