#!/usr/bin/perl

# Challenge 088
#
# TASK #2 › Spiral Matrix
# Submitted by: Mohammad S Anwar
# You are given m x n matrix of positive integers.
#
# Write a script to print spiral matrix as list.
#
# Example 1:
# Input:
#     [ 1, 2, 3 ]
#     [ 4, 5, 6 ]
#     [ 7, 8, 9 ]
# Ouput:
#     [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]
# Example 2:
# Input:
#     [  1,  2,  3,  4 ]
#     [  5,  6,  7,  8 ]
#     [  9, 10, 11, 12 ]
#     [ 13, 14, 15, 16 ]
# Output:
#     [ 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ]

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

# compute spiral
my @s = spiral(@m);
say "[ ", join(", ", @s), " ]";


sub spiral {
    my(@m) = @_;
    my @s;
    while (@m) {
        push @s, @{$m[0]};                  # put top row left-right
        shift @m;
        last unless @m;

        if (@{$m[0]}) {
            for my $r (0 .. $#m) {          # put right column top-bottom
                push @s, pop @{$m[$r]};
            }
        }

        push @s, reverse @{$m[-1]};         # put bottom row right-left
        pop @m;
        last unless @m;

        if (@{$m[0]}) {
            for my $r (reverse 0 .. $#m) {  # put left column top-bottom
                push @s, shift @{$m[$r]};
            }
        }
    }
    return @s;
}
