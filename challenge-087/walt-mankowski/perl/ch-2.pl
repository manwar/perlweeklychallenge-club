#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #2 › Largest Rectangle
# Submitted by: Mohammad S Anwar
#
# You are given matrix m x n with 0 and 1.
#
# Write a script to find the largest rectangle containing only
# 1. Print 0 if none found.

my $fname = $ARGV[0];
my $grid = parse_input($fname);

my $rows = $grid->@*;
my $cols = $grid->[0]->@*;

# loop over all the possible rectangles looking for the best one
my $best_area = 0;
my $best_row;
my $best_col;
my $best_height;
my $best_width;
for my $row1 (0..$rows-2) {
    for my $col1 (0..$cols-2) {
        for my $row2 ($row1+1..$rows-1) {
            my $height = $row2 - $row1 + 1;
            for my $col2 ($col1+1..$cols-1) {
                my $width = $col2 - $col1 + 1;
                my $area = $width * $height;
                next if $area <= $best_area;

                if (all_ones($grid, $row1, $row2, $col1, $col2)) {
                    $best_area = $area;
                    $best_row = $row1;
                    $best_col = $col1;
                    $best_height = $height;
                    $best_width = $width;
                }
            }
        }
    }
}

if ($best_area == 0) {
    say 0;
} else {
    for my $r (1..$best_height) {
        say "1 " x $best_width;
    }
}

# read in the matrix
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

sub all_ones($grid, $row1, $row2, $col1, $col2) {
    for my $r ($row1..$row2) {
        for my $c ($col1..$col2) {
            return 0 if $grid->[$r][$c] == 0;
        }
    }

    return 1;
}
