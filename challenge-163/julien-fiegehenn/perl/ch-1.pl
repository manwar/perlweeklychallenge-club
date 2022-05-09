#!/usr/bin/env perl
use strict;
use warnings;
use List::Util 'sum0';

# Task 1: Sum Bitwise Operator

# You are given list positive numbers, @n.
# Write script to calculate the sum of bitwise & operator for all unique pairs.

# Input: @n = (1, 2, 3)
# Output: 3
#
# Since (1 & 2) + (2 & 3) + (1 & 3) => 0 + 2 + 1 =>  3.

sub sum_bitwise {
    my @num = @_;

    my %seen;
    return sum0 map {
        my $first = $_;
        map {
                $first == $_ ? 0
              : $seen{ sprintf '%d_%d', sort $first, $_ }++ ? 0
              : ( $first & $_ )
        } @num;
    } @num;
}

use Test::More;

is sum_bitwise( 1, 2, 3 ), 3;
is sum_bitwise( 2, 3, 4 ), 2;

done_testing;
