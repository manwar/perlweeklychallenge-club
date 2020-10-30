#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use List::Util qw(min);
use autodie;

# TASK #2 › Find Square
# Submitted by: Mohammad S Anwar
#
# You are given matrix of size m x n with only 1 and 0.
#
# Write a script to find the count of squares having all four corners
# set as 1.

my $fname = $ARGV[0];
my $grid = parse_input($fname);

my $rows = $grid->@*;
my $cols = $grid->[0]->@*;

# now just loop over all the squares and count up those with 1s in all
# four corners
my $cnt = 0;
for my $row (0..$rows-1) {
    for my $col (0..$cols-1) {
        my $max_width = min($rows - $row, $cols - $col) - 1;
        for my $width (1..$max_width) {
            if ($grid->[$row][$col] == 1 &&
                $grid->[$row+$width][$col] == 1 &&
                $grid->[$row][$col+$width] == 1 &&
                $grid->[$row+$width][$col+$width] == 1) {
                $cnt++;
            }
        }
    }
}

say $cnt;

# read in the matrix and add a layer of 0s around the outside
sub parse_input($fname) {
    my @grid;

    open my $fh, '<', $fname;
    my $row = 0;
    while (my $line = <$fh>) {
        # remove whitespace;
        $line =~ s/\s//g;

        # convert to array
        my @c = split //, $line;

        for my $i (0..$#c) {
            $grid[$row][$i] = $c[$i];
        }
        $row++;
    }

    # return the grid
    return \@grid;
}
