#!/usr/bin/env perl

# Challenge 113
#
# TASK #1 - Represent Integer
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N and a digit $D.
#
# Write a script to check if $N can be represented as a sum of positive
# integers having $D at least once. If check passes print 1 otherwise 0.
#
# Example
# Input: $N = 25, $D = 7
# Output: 0 as there are 2 numbers between 1 and 25 having the digit 7
# i.e. 7 and 17. If we add up both we don't get 25.
#
# Input: $N = 24, $D = 7
# Output: 1

use Modern::Perl;
my($N, $D) = @ARGV;
say represent($N||0, $D||0) ? 1 : 0;

sub represent {
    my($n, $d) = @_;
    my $sum = 0;
    for (1..$n) {
        $sum += $_ if /$d/;
    }
    return $sum==$n;
}
