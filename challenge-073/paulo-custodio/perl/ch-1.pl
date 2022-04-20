#!/usr/bin/env perl

# Challenge 073
#
# TASK #1 › Min Sliding Window
# Submitted by: Mohammad S Anwar
# You are given an array of integers @A and sliding window size $S.
#
# Write a script to create an array of min from each sliding window.
#
# Example
# Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3
# Output: (0, 0, 0, 2, 3, 3, 4, 4)
#
# [(1 5 0) 2 9 3 7 6 4 8] = Min (0)
# [1 (5 0 2) 9 3 7 6 4 8] = Min (0)
# [1 5 (0 2 9) 3 7 6 4 8] = Min (0)
# [1 5 0 (2 9 3) 7 6 4 8] = Min (2)
# [1 5 0 2 (9 3 7) 6 4 8] = Min (3)
# [1 5 0 2 9 (3 7 6) 4 8] = Min (3)
# [1 5 0 2 9 3 (7 6 4) 8] = Min (4)
# [1 5 0 2 9 3 7 (6 4 8)] = Min (4)

use Modern::Perl;
use List::Util qw( min );

my($S, @A) = @ARGV;
say join(", ", min_sliding_window($S, @A));


sub min_sliding_window {
    my($s, @a) = @_;
    my @min;
    for my $i (0 .. @a-$s) {
        push @min, min(@a[$i..$i+$s-1]);
    }
    return @min;
}
