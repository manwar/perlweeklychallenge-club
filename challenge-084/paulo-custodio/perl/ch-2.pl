#!/usr/bin/perl

# Challenge 084
#
# TASK #2 › Find Square
# Submitted by: Mohammad S Anwar
# You are given matrix of size m x n with only 1 and 0.
#
# Write a script to find the count of squares having all four corners set as 1.
#
# Example 1:
# Input: [ 0 1 0 1 ]
#        [ 0 0 1 0 ]
#        [ 1 1 0 1 ]
#        [ 1 0 0 1 ]
#
# Output: 1
# Explanation:
# There is one square (3x3) in the given matrix with four corners as 1 starts at r=1;c=2.
# [ 1 0 1 ]
# [ 0 1 0 ]
# [ 1 0 1 ]
# Example 2:
# Input: [ 1 1 0 1 ]
#        [ 1 1 0 0 ]
#        [ 0 1 1 1 ]
#        [ 1 0 1 1 ]
#
# Output: 4
# Explanation:
# There is one square (4x4) in the given matrix with four corners as 1 starts at r=1;c=1.
# There is one square (3x3) in the given matrix with four corners as 1 starts at r=1;c=2.
# There are two squares (2x2) in the given matrix with four corners as 1. First starts
# at r=1;c=1 and second starts at r=3;c=3.
# Example 3:
# Input: [ 0 1 0 1 ]
#        [ 1 0 1 0 ]
#        [ 0 1 0 0 ]
#        [ 1 0 0 1 ]
#
# Output: 0

use strict;
use warnings;
use 5.030;

# read matrix from input
my @m;
my $ncols;
while (<>) {
    my @cols = split(' ', s/\D/ /gr);       # ignore all but numbers
    die "invalid matrix\n" if defined($ncols) && $ncols != scalar(@cols);
    $ncols = scalar(@cols);
    push @m, \@cols;
}

say count_squares(@m);


# count squares larger than 1
sub count_squares {
    my(@m) = @_;
    my $nrows = scalar(@m);
    return 0 if $nrows < 2;
    my $ncols = scalar(@{$m[0]});
    return 0 if $ncols < 2;

    my $count = 0;
    for my $row (0 .. $nrows-1) {
        for my $col (0 .. $ncols-1) {
            if ($m[$row][$col]) {
                for (my $d = 1; $row+$d < $nrows && $col+$d < $ncols; $d++) {
                    if ($m[$row+$d][$col] && $m[$row][$col+$d] && $m[$row+$d][$col+$d]) {
                        $count++;
                    }
                }
            }
        }
    }
    return $count;
}
