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
use Math::Combinatorics;
use List::Util 'sum';

sub nums_containing {
    my($n, $d) = @_;
    my @nums;
    for (1..$n) {
        push @nums, $_ if /$d/;
    }
    return @nums;
}

sub represent {
    my($n, $d) = @_;
    my @nums = nums_containing($n, $d);
    for my $k (1 .. @nums) {
        for my $combin (combine($k, @nums)) {
            return 1 if sum(@$combin) == $n;
        }
    }
    return 0;
}


my($N, $D) = @ARGV or die "Usage: ch-1.pl N D\n";
say represent($N, $D) ? 1 : 0;
