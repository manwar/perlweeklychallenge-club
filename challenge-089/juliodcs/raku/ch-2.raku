#! /usr/bin/raku

constant LINES  = ((0, 1, 2), (3, 4, 5), (6, 7, 8), (0, 3, 6), (1, 4, 7), (2, 5, 8), (0, 4, 8), (2, 4, 6));
constant CENTER = 4;

# Brute force, but we optimize it a little by requiring center element == 5
# This is mathematically true for a 3x3 matrix. See: https://math.stackexchange.com/a/1789360/842542
sub magic-matrix {
    for (1 .. 9).permutations.grep({ $_[CENTER] == 5 }) -> @list {
        print-as-matrix @list if 15 == all LINES.map: *.map({ @list[$^i] }).sum
    }
}

sub print-as-matrix(@list) {
    say "{@list.rotor(3).map(*.join: ' ').join: "\n"}\n";
}

magic-matrix;
