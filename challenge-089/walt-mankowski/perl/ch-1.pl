#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #1 › GCD Sum
# Submitted by: Mohammad S Anwar
#
# You are given a positive integer $N.
#
# Write a script to sum GCD of all possible unique pairs between 1 and $N.

sub gcd($a, $b) {
    return $b == 0 ? $a : gcd($b, $a % $b);
}

my $n = $ARGV[0];
my $sum = 0;
for my $i (1..$n-1) {
    for my $j ($i+1..$n) {
        $sum += gcd($j, $i);
    }
}

say $sum;
