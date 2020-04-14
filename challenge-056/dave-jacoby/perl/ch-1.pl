#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ fc postderef say signatures state switch };
no warnings qw{ experimental };

diffk( 2, 2, 7, 9 );

# You are given an array @N of positive integers (sorted)
# and another non negative integer k.
#
# Write a script to find if there exists 2 indices i and j
# such that A[i] - A[j] = k and i != j.
#
# It should print the pairs of indices, if any such pairs exist.

## k is positive, N is sorted, so i will have to be higher than j
sub diffk ( $k, @N ) {
    for my $j ( 0 .. -1 + scalar @N ) {
        for my $i ( $j + 1 .. -1 + scalar @N ) {
            say join ", ", $i, $j if $k == $N[$i] - $N[$j];
        }
    }

}
