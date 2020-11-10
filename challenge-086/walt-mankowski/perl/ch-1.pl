#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use Algorithm::Combinatorics qw(combinations);

# TASK #1 › Pair Difference
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers @N and an integer $A.
#
# Write a script to find find if there exists a pair of elements in
# the array whose difference is $A.
#
# Print 1 if exists otherwise 0.

my @n = @ARGV[0..$#ARGV-1];
my $a = $ARGV[-1];

my $res = 0;
my $iter = combinations(\@n, 2);
while (my $c = $iter->next) {
    if (abs($c->[0] - $c->[1]) == $a) {
        $res = 1;
        last;
    }
}

say $res;
