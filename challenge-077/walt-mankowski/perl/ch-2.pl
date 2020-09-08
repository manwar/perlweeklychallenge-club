#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use List::Util qw(sum);
use autodie;

# TASK #2 › Lonely X
# Submitted by: Mohammad S Anwar
#
# You are given m x n character matrix consists of O and X only.
#
# Write a script to count the total number of X surrounded by O
# only. Print 0 if none found.

# read in the matrix and add a layer of 0s around the outside
sub parse_input($fname) {
    my @grid;

    open my $fh, '<', $fname;
    my $row = 0;
    my $width = 0;
    while (my $line = <$fh>) {
        # remove whitespace;
        $line =~ s/\s//g;

        # convert to array
        my @c = split //, $line;

        # add top row if needed
        unless (@grid) {
            $width = 2 + @c;
            for my $col (0..$width-1) {
                $grid[$row][$col] = 0;
            }
            $row = 1;
        }
        $grid[$row][0] = 0;
        for my $i (0..$#c) {
            $grid[$row][$i+1] = $c[$i] eq 'X' ? 1 : 0;
        }
        $grid[$row][$width-1] = 0;
        $row++;
    }

    # make bottom line
    for my $col (0..$width-1) {
        $grid[$row][$col] = 0;
    }

    # return the grid
    return \@grid;
}

my $fname = $ARGV[0];
my $grid = parse_input($fname);

my $rows = $grid->@*;
my $cols = $grid->[0]->@*;

my $count = 0;
for my $row (1..$rows-2) {
    for my $col (1..$cols-2) {
        next unless $grid->[$row][$col] == 1;
        if (sum($grid->[$row-1]->@[$col-1..$col+1]) +
            sum($grid->[$row]->@[$col-1..$col+1]) +
            sum($grid->[$row+1]->@[$col-1..$col+1]) == 1) {
            $count++;
        }
    }
}

say $count;

