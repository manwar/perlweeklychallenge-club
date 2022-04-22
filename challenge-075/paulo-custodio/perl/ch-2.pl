#!/usr/bin/env perl

# Challenge 075
#
# TASK #2 › Largest Rectangle Histogram
# Submitted by: Mohammad S Anwar
# You are given an array of positive numbers @A.
#
# Write a script to find the largest rectangle histogram created by the given
# array.
#
# BONUS: Try to print the histogram as shown in the example, if possible.
#
# Example 1:
#
# Input: @A = (2, 1, 4, 5, 3, 7)
#      7           #
#      6           #
#      5       #   #
#      4     # #   #
#      3     # # # #
#      2 #   # # # #
#      1 # # # # # #
#      _ _ _ _ _ _ _
#        2 1 4 5 3 7
# Looking at the above histogram, the largest rectangle (4 x 3) is formed by
# columns (4, 5, 3 and 7).
#
# Output: 12
#
# Example 2:
#
# Input: @A = (3, 2, 3, 5, 7, 5)
#      7         #
#      6         #
#      5       # # #
#      4       # # #
#      3 #   # # # #
#      2 # # # # # #
#      1 # # # # # #
#      _ _ _ _ _ _ _
#        3 2 3 5 7 5
# Looking at the above histogram, the largest rectangle (3 x 5) is formed by
# columns (5, 7 and 5).
#
# Output: 15

use Modern::Perl;
use List::Util qw( max );

my @A = @ARGV;
my @hist = make_histogram(@A);
my $max_area = max_area(@hist);
say $max_area;


sub make_histogram {
    my(@a) = @_;
    my $max = max(@a);
    my @hist;
    for my $c (0 .. $#a) {
        for my $r (0 .. $max-1) {
            $hist[$r][$c] = $r>=$a[$c] ? 0 : 1;
        }
    }
    return @hist;
}

sub max_area {
    my(@hist) = @_;
    my $max_area = 0;
    for my $r0 (0 .. @hist-1) {
        for my $c0 (0 .. @{$hist[$r0]}-1) {
            if ($hist[$r0][$c0]) {
                for my $height (1 .. @hist-$r0) {
                    for my $width (1 .. @{$hist[$r0]}-$c0) {
                        my $all_ones = 1;
                        for my $r ($r0 .. $r0+$height-1) {
                            for my $c ($c0 .. $c0+$width-1) {
                                if (!$hist[$r][$c]) {
                                    $all_ones = 0;
                                }
                            }
                        }
                        if ($all_ones) {
                            $max_area = max($max_area, $width*$height);
                        }
                    }
                }
            }
        }
    }
    return $max_area;
}
