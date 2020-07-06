#!/usr/bin/env raku

# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-068/

# Comments: https://andrewshitov.com/2020/07/06/raku-challenge-week-68/

my @input =
    [1, 0, 1],
    [1, 1, 1],
    [1, 1, 1];

for empty_lines(@input) X empty_lines([Z] @input) -> ($row, $col) {
    @input[$row][$_] = 0 for ^@input[0];
    @input[$_][$col] = 0 for ^@input;
}

say @input.join("\n");

sub empty_lines(@data) {
    grep {!all(@data[$_])}, @data.keys;
}

# Output:

# 0 0 0
# 1 0 1
# 1 0 1
