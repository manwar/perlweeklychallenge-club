#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #2 › Power of Two Integers
# Submitted by: Mohammad S Anwar
#
# You are given a positive integer $N.
#
# Write a script to find if it can be expressed as a ** b where a > 0
# and b > 1. Print 1 if you succeed otherwise 0.

# Note: I'm assuming that a and b must be integers, because otherwise
# there are trivial solutions:
# sqrt(n) ** 2 or (n**(2/3))**(3/2)
#
# Algorithm: If a**b = n and a and b are integers, then log(n)/log(a) = b
# must also be an integer. is_whole() accounts for floating point
# roundoff errors.

my $EPS = 1e-6;
my $n = $ARGV[0];
my $logn = log($n);
my $res = 0;

for my $i (2..round(sqrt($n))) {
    my $pow = $logn / log($i);
    if (is_whole($pow, $EPS)) {
        $res = 1;
        last;
    }
}

say $res;

sub round($n) {
    return sprintf "%.0f", $n;
}

sub is_whole($n, $eps) {
    return abs($n - round($n)) < $eps;
}
