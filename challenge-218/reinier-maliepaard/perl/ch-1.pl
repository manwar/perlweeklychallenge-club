#!/usr/bin/perl
use strict;
use warnings;

# Comment: the maximum product of 3 numbers can come from either:
# - The 3 largest numbers
# - The 2 smallest (most negative) + the largest

sub maximum_product {

    my ($arr) = @_;

    my @sorted = sort { $a <=> $b } @$arr;
    my $n = @sorted;

    my $prod1 = $sorted[$n-1] * $sorted[$n-2] * $sorted[$n-3]; # 3 largest
    my $prod2 = $sorted[0] * $sorted[1] * $sorted[$n-1];       # 2 smallest + largest

    my $max_product = $prod1 > $prod2 ? $prod1 : $prod2;

    return $max_product;
}

# Tests

my @list;

# Example 1
Input: @list = (3, 1, 2);
print maximum_product(\@list), "\n"; # Output: 6

# Example 2
Input: @list = (4, 1, 3, 2);
print maximum_product(\@list), "\n"; # Output: 24

# Example 3
Input: @list = (-1, 0, 1, 3, 1);
print maximum_product(\@list), "\n"; # Output: 3

# Example 4
Input: @list = (-8, 2, -9, 0, -4, 3);
print maximum_product(\@list), "\n"; # Output: 216
