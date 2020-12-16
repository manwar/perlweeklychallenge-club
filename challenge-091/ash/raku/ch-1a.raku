#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-091/

# Comments: https://andrewshitov.com/2020/12/14/raku-challenge-week-91/

unit sub MAIN(Int $n = 1122234);

# Cannot process more than 10 repeating digits.
# Otherwise use some spelling module.
my @spell = <one two three four five six seven eight nine ten>;

put gather for $n ~~ m:g/ (\d) $0* / {
    take @spell[.Str.chars - 1];
    take .[0];
}

# Output:
# two 1 three 2 one 3 one 4
