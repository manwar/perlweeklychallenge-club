#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);

# TASK #1 › Triplet Sum
# Submitted by: Mohammad S Anwar
#
# You are given an array of real numbers greater than zero.
#
# Write a script to find if there exists a triplet (a,b,c) such that
# 1 < a+b+c < 2. Print 1 if you succeed otherwise 0.

my @data = @ARGV;
my $iter = combinations(\@data, 3);
my $res = 0;
while (my $c = $iter->next) {
    my $sum = sum $c->@*;
    if (1 < $sum < 2) {
        $res = 1;
        last;
    }
}

say $res;
