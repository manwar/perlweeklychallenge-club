#!/usr/bin/env perl

use Modern::Perl;

# TASK #2 › Power of Two Integers
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.

# Write a script to find if it can be expressed as a ^ b where a > 0 and b > 1. Print 1 if you succeed otherwise 0.

# Example 1:
# Input: 8
# Output: 1 as 8 = 2 ^ 3
# Example 2:
# Input: 15
# Output: 0
# Example 3:
# Input: 125
# Output: 1 as 125 = 5 ^ 3

my $N = shift;

if ( $N == 1 ) {
    say 1;
    exit;
}

for my $a ( 2 .. sqrt $N ) {
    my $b = 1;
    my $p;
    do {
        $b++;
        $p = $a**$b;
    } until $p >= $N;
    if ( $p == $N ) {
        say 1;
        exit;
    }
}
say 0;
