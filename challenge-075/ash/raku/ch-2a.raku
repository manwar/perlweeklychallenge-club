#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-075/

# Comments: https://andrewshitov.com/2020/08/29/largest-rectangle-histogram-the-raku-challenge-week-75-task-2/

# my @hist = 2, 1, 4, 5, 3, 7;
my @hist = 3, 2, 3, 5, 7, 5;

my $max = 0;
for (^@hist).combinations(2) -> ($x, $y) {
    $max = max($max, min(@hist[$x .. $y]) * ($y - $x + 1));
}

say "The area of a biggest rectangle is $max.";

# Output:
#
# $ raku ch-2a.raku 
# The area of a biggest rectangle is 15.