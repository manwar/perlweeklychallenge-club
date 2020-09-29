#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #2 › Count Candies
# Submitted by: Mohammad S Anwar
#
# You are given rankings of @N candidates.
#
# Write a script to find out the total candies needed for all
# candidates. You are asked to follow the rules below:
#
# a) You must given at least one candy to each candidate.
#
# b) Candidate with higher ranking get more candies than their
#    immediate neighbors on either side.

my @n = @ARGV;
my $candy = @n;

# right neighbors
for my $i (0..$#n-1) {
    $candy++ if $n[$i] > $n[$i+1];
}

# left neighbors
for my $i (1..$#n) {
    $candy++ if $n[$i] > $n[$i-1];
}

say $candy;
