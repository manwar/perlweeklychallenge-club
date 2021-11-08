#!/usr/bin/env perl

# Challenge 117
#
# TASK #2 - Find Possible Paths
# Submitted by: E. Choroba
# You are given size of a triangle.
#
# Write a script to find all possible paths from top to the bottom right
# corner.
#
# In each step, we can either move horizontally to the right (H), or move
# downwards to the left (L) or right (R).
#
# BONUS: Try if it can handle triangle of size 10 or 20.
#
# Example 1:
# Input: $N = 2
#
#            S
#           / \
#          / _ \
#         /\   /\
#        /__\ /__\ E
#
# Output: RR, LHR, LHLH, LLHH, RLH, LRH
# Example 2:
# Input: $N = 1
#
#            S
#           / \
#          / _ \ E
#
# Output: R, LH

use Modern::Perl;
my $N = shift || 1;
say join(', ', paths($N));

sub paths {
    my($size) = @_;
    my @paths;
    find_paths(\@paths, $size, '', 0, 0);
    return @paths;
}

sub find_paths {
    my($paths, $size, $path, $row, $col) = @_;
    if ($row == $size && $col == $size) {   # reached end
        push @$paths, $path;
    }
    else {
        if ($row < $size) {
            find_paths($paths, $size, $path.'L', $row+1, $col);
            find_paths($paths, $size, $path.'R', $row+1, $col+1);
        }
        if ($col < $row) {
            find_paths($paths, $size, $path.'H', $row, $col+1);
        }
    }
}
