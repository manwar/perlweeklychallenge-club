#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use List::Util qw(min);

# TASK #1 › Min Sliding Window
# Submitted by: Mohammad S Anwar

# You are given an array of integers @A and sliding window size $S.

# Write a script to create an array of min from each sliding window.
# Example
# Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3
# Output: (0, 0, 0, 2, 3, 3, 4, 4)

# [(1 5 0) 2 9 3 7 6 4 8] = Min (0)
# [1 (5 0 2) 9 3 7 6 4 8] = Min (0)
# [1 5 (0 2 9) 3 7 6 4 8] = Min (0)
# [1 5 0 (2 9 3) 7 6 4 8] = Min (2)
# [1 5 0 2 (9 3 7) 6 4 8] = Min (3)
# [1 5 0 2 9 (3 7 6) 4 8] = Min (3)
# [1 5 0 2 9 3 (7 6 4) 8] = Min (4)
# [1 5 0 2 9 3 7 (6 4 8)] = Min (4)

my @a = @ARGV;
my $s = pop @a;
my @out = map { min @a[$_..$_+$s-1] } 0..(@a-$s);
say "@out";
