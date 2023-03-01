#!/usr/bin/env raku
sub MAIN (*@args) { put array-pairings(@args) }
sub array-pairings (Array[Int]() $array) { $array.sort[0, 2 ... *].sum }
