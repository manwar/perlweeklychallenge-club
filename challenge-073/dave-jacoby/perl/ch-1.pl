#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ min };

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

my @array = ( 1, 5, 0, 2, 9, 3, 7, 6, 4, 8 );
my $s = 3;

sliding_window( $s, \@array );

sub sliding_window ( $s, $arr ) {
    my @arr   = $arr->@*;
    my $max_n = $#arr;

    for my $n ( 0 .. $#arr ) {
        next if $n + 2 > $max_n;
        my $min = min map { $arr[$_] } $n .. $n + 2;

        print '[';
        for my $i ( 0 .. $#arr ) {
            print $i == $n ? '(' : ' ';
            print $arr[$i];
            print $i == $n +2 ? ')' : ' ';
        }
        say qq{] = Min ($min)};
    }
}

