#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-070/

# Comments: https://andrewshitov.com/2020/07/20/gray-code-in-raku/

# Usage:
# $ raku ch-2.raku 4

put map {$_ +^ ($_ div 2)}, ^2**@*ARGS[0];

# Output for N = 4 (4 bits)
# 0 1 3 2 6 7 5 4 12 13 15 14 10 11 9 8
