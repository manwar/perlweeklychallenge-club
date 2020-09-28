#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use List::Util qw(max);

# TASK #2 › Trapped Rain Water
# Submitted by: Mohammad S Anwar
#
# You are given an array of positive numbers @N.
#
# Write a script to represent it as Histogram Chart and find out how
# much water it can trap.

my @a = @ARGV;

# build the histogram
my $rows = max(@a);
my $cols = @a;
my @hist;
for my $col (0..$#a) {
    for my $row (0..$rows-1) {
        $hist[$row][$col] = $row < $a[$col] ? 1 : 0;
    }
}

my $units = 0;
for my $row (1..$rows-1) {
    for my $col (1..$cols-1) {
        $units++ if trapped($row, $col, $cols, @hist);
    }
}

say $units;

sub trapped($row, $col, $max_col, @hist) {
    # check if we're at a wall
    return 0 if $hist[$row][$col];

    # look for left wall
    my $left = 0;
    for (my $c = $col-1; $c >= 0 && !$left; $c--) {
        $left = 1 if $hist[$row][$c];
    }

    # look for right wall
    my $right = 0;
    for (my $c = $col+1; $c < $max_col && !$right; $c++) {
        $right = 1 if $hist[$row][$c];
    }

    return $left && $right;
}
