#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-351/#TASK1
#
# Task 1: Special Average
# =======================
#
# You are given an array of integers.
#
# Write a script to return the average excluding the minimum and maximum of the
# given array.
#
## Example 1
##
## Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
## Output: 5250
##
## Min: 2000
## Max: 8000
## Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250
#
#
## Example 2
##
## Input: @ints = (100_000, 80_000, 110_000, 90_000)
## Output: 95_000
##
## Min: 80_000
## Max: 110_000
## Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000
#
#
## Example 3
##
## Input: @ints = (2500, 2500, 2500, 2500)
## Output: 0
##
## Min: 2500
## Max: 2500
## Avg: 0
#
#
## Example 4
##
## Input: @ints = (2000)
## Output: 0
##
## Min: 2000
## Max: 2000
## Avg: 0
#
#
## Example 5
##
## Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
## Output: 3500
##
## Min: 1000
## Max: 6000
## Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500
#
############################################################
##
## discussion
##
############################################################
#
# We find both the minimum and the maximum. Then we skip those
# while calculating the average (sum up all remaining parts and
# divide by their number).

use v5.36;

special_average(8000, 5000, 6000, 2000, 3000, 7000);
special_average(100_000, 80_000, 110_000, 90_000);
special_average(2500, 2500, 2500, 2500);
special_average(2000);
special_average(1000, 2000, 3000, 4000, 5000, 6000);

sub special_average(@ints) {
    say "Input: (" . join(",", @ints) . ")";
    my $min = $ints[0];
    my $max = $ints[0];
    foreach my $elem (@ints) {
        if($elem > $max) {
            $max = $elem;
        }
        if($elem < $min) {
            $min = $elem;
        }
    }
    my $c = 0;
    my $sum = 0;
    foreach my $elem (@ints) {
        next if $elem == $min;
        next if $elem == $max;
        $c++;
        $sum += $elem;
    }
    if($c) {
        say "Output: " . $sum / $c;
    } else {
        say "Output: 0";
    }
}

