#!/usr/bin/perl

# Challenge 077
#
# TASK #2 › Lonely X
# Submitted by: Mohammad S Anwar
# You are given m x n character matrix consists of O and X only.
#
# Write a script to count the total number of X surrounded by O only. Print 0 if none found.
#
# Example 1:
# Input: [ O O X ]
#        [ X O O ]
#        [ X O O ]
#
# Output: 1 as there is only one X at the first row last column surrounded by only O.
# Example 2:
# Input: [ O O X O ]
#        [ X O O O ]
#        [ X O O X ]
#        [ O X O O ]
#
# Output: 2
#
#     a) First  X found at Row 1 Col 3.
#
#     b) Second X found at Row 3 Col 4.

use strict;
use warnings;
use 5.030;

my @m = @ARGV;
for (@m) { $_ = [split //, $_]; }

my $lonely = 0;
for my $row (0 .. $#m) {
    for my $col (0 .. $#{$m[0]}) {
        if ($m[$row][$col] eq 'X') {
            my $neigh = 0;
            for my $dr (-1 .. 1) {
                for my $dc (-1 .. 1) {
                    if (!($dr == 0 && $dc == 0)) {
                        if ($row+$dr >= 0 && $row+$dr <= $#m) {
                            if ($col+$dc >= 0 && $col+$dc <= $#{$m[0]}) {
                                if ($m[$row+$dr][$col+$dc] eq 'X') {
                                    $neigh++;
                                }
                            }
                        }
                    }
                }
            }
            $lonely++ if $neigh==0;
        }
    }
}

say $lonely;
