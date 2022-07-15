#!/usr/bin/env perl
use v5.36;

# Task 1: Esthetic Number
#
# You are given a positive integer, $n.
#
# Write a script to find out if the given number is Esthetic Number.
#
#     An esthetic number is a positive integer where every adjacent
#     digit differs from its neighbour by 1.
#
# For example,
#
# 5456 is an esthetic number as |5 - 4| = |4 - 5| = |5 - 6| = 1
# 120 is not an esthetic number as |1 - 2| != |2 - 0| != 1

sub is_esthetic($n) {
    my @d = split //, $n;
    for my $i (1..$#d) {
        return 0 unless abs($d[$i-1] - $d[$i]) == 1;
    }
    return 1;
}

my $n = @ARGV[0];
printf "%d is%s an esthetic number\n", $n, is_esthetic($n) ? "" : " not";
