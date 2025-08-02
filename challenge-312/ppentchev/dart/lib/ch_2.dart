// SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
// SPDX-License-Identifier: BSD-2-Clause

import 'package:characters/characters.dart' show Characters;

class Box {
  int red;
  int green;
  int blue;

  Box({this.red = 0, this.green = 0, this.blue = 0});

  bool get isComplete => this.red > 0 && this.green > 0 && this.blue > 0;

  @override
  bool operator ==(Object other) {
    Box other_box = other as Box;
    return this.red == other_box.red &&
        this.green == other_box.green &&
        this.blue == other_box.blue;
  }

  @override
  String toString() {
    return "Box(red=${this.red}, green=${this.green}, blue=${this.blue})";
  }

  void add_ball(String color) {
    switch (color) {
      case "R":
        this.red += 1;

      case "G":
        this.green += 1;

      case "B":
        this..blue += 1;

      default:
        throw "Unrecognized ball color '$color'";
    }
  }
}

Map<int, Box> parse(String word) {
  final Map<int, Box> res = Map();
  if (word.isEmpty) {
    return res;
  }

  final letters = List.from(Characters(word));
  while (!letters.isEmpty) {
    final color = letters.removeAt(0);
    final box_idx = int.parse(letters.removeAt(0), radix: 10);
    res.putIfAbsent(box_idx, Box.new);
    res[box_idx]!.add_ball(color);
  }
  return res;
}
