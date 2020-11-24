#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #2 › Spiral Matrix
# Submitted by: Mohammad S Anwar
#
# You are given m x n matrix of positive integers.
#
# Write a script to print spiral matrix as list.

my $fname = $ARGV[0];
my $grid = parse_input($fname);

my $rows = $grid->@*;
my $cols = $grid->[0]->@*;

my %turn = (e => 's',
            s => 'w',
            w => 'n',
            n => 'e',
           );

my %dir = (e => [0,1],
           s => [1,0],
           w => [0,-1],
           n => [-1,0],
          );

my %seen;
my @res;
my $r = 0;
my $c = 0;
my $dir = 'e';

while (@res < $rows * $cols) {
    push @res, $grid->[$r][$c];
    $seen{"$r,$c"} = 1;
    my $r1 = $r + $dir{$dir}->[0];
    my $c1 = $c + $dir{$dir}->[1];
    if ($r1 < 0 || $r1 >= $rows ||
        $c1 < 0 || $c1 >= $cols ||
        defined $seen{"$r1,$c1"}) {

        # turn and recalculate $r1 and $c1
        $dir = $turn{$dir};
        $r1 = $r + $dir{$dir}->[0];
        $c1 = $c + $dir{$dir}->[1];
    }
    ($r,$c) = ($r1,$c1);
}

say "@res";

# read in the matrix
sub parse_input($fname) {
    my @grid;

    open my $fh, '<', $fname;
    my $row = 0;
    while (my $line = <$fh>) {
        # remove whitespace;
        $line =~ s/\s//g;

        # convert to array
        my @c = split /,/, $line;

        for my $i (0..$#c) {
            $grid[$row][$i] = $c[$i];
        }
        $row++;
    }

    # return the grid
    return \@grid;
}
