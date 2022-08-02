#!/usr/bin/env perl
use v5.36;

# Task 1: Permuted Multiples
# Submitted by: Mohammad S Anwar
#
# Write a script to find the smallest positive integer x such that x,
# 2x, 3x, 4x, 5x and 6x are permuted multiples of each other.
#
# For example, the integers 125874 and 251748 are permutated multiples
# of each other as
#
# 251784 = 2 x 125874
#
# and also both have the same digits but in different order.

sub sorted_digits($x) {
    return join '', sort split //, $x;
}

my $i = 1;
my $done = 0;
while (!$done) {
    my $sorted = sorted_digits($i);
    for my $j (2..6) {
        last unless sorted_digits($i * $j) == $sorted;
        if ($j == 6) {
            for my $k (1..6) {
                printf "%d ", $i * $k;
            }
            say "";
            $done = 1;
        }
    }
    $i++;
}
