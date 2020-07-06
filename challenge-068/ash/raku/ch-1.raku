#!/usr/bin/env raku

# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-068/

# Comments: https://andrewshitov.com/2020/07/06/raku-challenge-week-68/

my @input =
    [1, 0, 1],
    [1, 1, 1],
    [1, 1, 1];

my @rows = empty_lines(@input);
my @cols = empty_lines([Z] @input);

for ((@rows X ^@input[0]), (^@input X @cols)).flat -> $row, $col {
    @input[$row][$col] = 0;
}

say @input.join("\n");

sub empty_lines(@data) {
    grep {!all(@data[$_])}, @data.keys;
}

# Output:

# 0 0 0
# 1 0 1
# 1 0 1
