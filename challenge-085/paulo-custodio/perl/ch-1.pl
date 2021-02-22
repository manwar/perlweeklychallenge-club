#!/usr/bin/perl

# Challenge 085
#
# TASK #1 › Triplet Sum
# Submitted by: Mohammad S Anwar
# You are given an array of real numbers greater than zero.
#
# Write a script to find if there exists a triplet (a,b,c) such that 1 < a+b+c < 2. Print 1 if you succeed otherwise 0.
#
# Example 1:
# Input: @R = (1.2, 0.4, 0.1, 2.5)
# Output: 1 as 1 < 1.2 + 0.4 + 0.1 < 2
# Example 2:
# Input: @R = (0.2, 1.5, 0.9, 1.1)
# Output: 0
# Example 3:
# Input: @R = (0.5, 1.1, 0.3, 0.7)
# Output: 1 as 1 < 0.5 + 1.1 + 0.3 < 2

use strict;
use warnings;
use 5.030;

my @R = @ARGV;
@R >= 3 or die "Need at least 3 values\n";

say found(@R);

# check sum of a triplet
sub check {
    my($result, $a, $b, $c) = @_;
    my $sum = $a + $b + $c;
    if (1 < $sum && $sum < 2) {
        $$result = 1;
    }
}

# next combination
sub next_combination {
    my($result, $set, $comb, $k) = @_;
    if ($$result) {                 # trim tree, already found a solution
        return;
    }
    elsif ($k == 0) {               # check one triplet
        check($result, @$comb);
    }
    else {                          # compute next combination
        my @comb = @$comb;
        for my $i (scalar(@comb) .. scalar(@$set)-$k) {
            push @comb, $set->[$i];
            next_combination($result, $set, \@comb, $k-1);
            pop @comb;
        }
    }
}

sub found {
    my(@set) = @_;
    my $result = 0;
    next_combination(\$result, \@set, [], 3);       # check triplets
    return $result;
}
