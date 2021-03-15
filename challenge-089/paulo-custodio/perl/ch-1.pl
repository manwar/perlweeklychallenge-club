#!/usr/bin/perl

# Challenge 089

# TASK #1 › GCD Sum
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# Write a script to sum GCD of all possible unique pairs between 1 and $N.

# This solution uses a recursive algorithm to compute the GCD.

use strict;
use warnings;

sub gcd {
    my($a, $b) = @_;
    if ($a == 0) {
        return $b;
    }
    else {
        return gcd($b % $a, $a);
    }
}

sub sum_gcd {
    my($n) = @_;
    my $sum = 0;
    for my $a (1 .. $n-1) {
        for my $b ($a+1 .. $n) {
            $sum += gcd($a, $b);
        }
    }
    return $sum;
}

my $n = shift;
print sum_gcd($n), "\n";
