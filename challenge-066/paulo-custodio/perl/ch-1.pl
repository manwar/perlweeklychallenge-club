#!/usr/bin/env perl

# Challenge 066
#
# TASK #1 › Divide Integers
# Submitted by: Mohammad S Anwar
#
# You are given two integers $M and $N.
#
# Write a script to divide the given two integers i.e. $M / $N without using
# multiplication, division and mod operator and return the floor of the result
# of the division.
#
# Example 1:
# Input: $M = 5, $N = 2
# Output: 2
# Example 2:
# Input: $M = -5, $N = 2
# Output: -3
# Example 3:
# Input: $M = -5, $N = -2
# Output: 2

use Modern::Perl;

my($M, $N) = @ARGV;
say divide($M, $N);

sub divide {
    my($m, $n) = @_;
    my($q, $r) = divide1(abs($m), abs($n));
    if ($m>=0 && $n<0 || $m<0 && $n>=0) {
        $q = -$q;
        if ($r!=0) {
            $q--;
        }
    }
    return $q;
}

sub divide1 {
    my($m, $n) = @_;
    my $q = 0;
    while ($m >= $n) {
        $m -= $n;
        $q++;
    }
    my $r = $m;
    return ($q, $r);
}
