#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #2 › Power Integers
# Submitted by: Mohammad S Anwar
#
# You are given an integer $N.
#
# Write a script to check if the given number can be expressed as m^n
# where m and n are positive integers. Otherwise print 0.
#
# Please make sure m > 1 and n > 1.
#
# BONUS: If there are more than one ways to express the given number
# then print all possible solutions.
#
# Example 1:
# For given $N = 9, it should print 3^2.
#
# Example 2:
# For given $N = 45, it should print 0.
#
# Example 3:
# For given $N = 64, it should print all or one of 8^2 or 2^6 or 4^3.

# My algorithm is this:
#   Loop over all the m's from 2 to sqrt(N)
#   If m can be raised to an integer power to equal N, then log_m N is an integer

my $N = shift @ARGV;
my $logn = log($N);
my $found = 0;
for my $m (2..sqrt($N)) {
    my $n = $logn / log($m);
    if (is_int($n)) {
        say "$m^$n";
        $found = 1;
    }
}

say 0 unless $found;

sub is_int($n) {
    my $EPS = 1e-10;
    my $round = sprintf "%.0f", $n;
    return abs($round - $n) < $EPS;
}
