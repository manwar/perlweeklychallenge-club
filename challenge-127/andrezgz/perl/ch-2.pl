#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-127/
# Task #2
#
# Conflict Intervals
# You are given a list of intervals.
#
# Write a script to find out if the current interval conflicts with any of the previous intervals.
#
# Example
# Input: @Intervals = [ (1,4), (3,5), (6,8), (12, 13), (3,20) ]
# Output: [ (3,5), (3,20) ]
#
#     - The 1st interval (1,4) do not have any previous intervals to compare with, so skip it.
#     - The 2nd interval (3,5) does conflict with previous interval (1,4).
#     - The 3rd interval (6,8) do not conflicts with any of the previous intervals (1,4) and (3,5), so skip it.
#     - The 4th interval (12,13) again do not conflicts with any of the previous intervals (1,4), (3,5) and (6,8), so skip it.
#     - The 5th interval (3,20) conflicts with the first interval (1,4).
#
# Input: @Intervals = [ (3,4), (5,7), (6,9), (10, 12), (13,15) ]
# Output: [ (6,9) ]
#
#     - The 1st interval (3,4) do not have any previous intervals to compare with, so skip it.
#     - The 2nd interval (5,7) do not conflicts with the previous interval (3,4), so skip it.
#     - The 3rd interval (6,9) does conflict with one of the previous intervals (5,7).
#     - The 4th interval (10,12) do not conflicts with any of the previous intervals (3,4), (5,7) and (6,9), so skip it.
#     - The 5th interval (13,15) do not conflicts with any of the previous intervals (3,4), (5,7), (6,9) and (10,12), so skip it.

use strict;
use warnings;
use feature 'say';

my @input;
push @input, [ split /,/ ] for @ARGV;

my @conflict;
OUTER:
for my $cur (1..$#input) {
    for my $prev (0..$cur-1) {
        next if $input[$cur]->[0] > $input[$prev]->[1];
        next if $input[$cur]->[1] < $input[$prev]->[0];
        push @conflict, $input[$cur];
        next OUTER;
    }
}

say join ' ', map { sprintf '%d,%d', @$_ } @conflict;


__END__

$ perl ch-2.pl 1,4 3,5 6,8 12,13 3,20
3,5 3,20

$ perl ch-2.pl 3,4 5,7 6,9 10,12 13,15
6,9

$ perl ch-2.pl 3,4 8,9 5,7 12,13 6,7
6,7

$ perl ch-2.pl 3,4 9,11 6,10 12,13
6,10

$ perl ch-2.pl 1,2 3,5 6,8 12,13 9,11
