#!/usr/bin/env perl

# Challenge 061
#
# TASK #1 › Product SubArray
# Reviewed by: Ryan Thompson
# Given a list of 4 or more numbers, write a script to find the contiguous
# sublist that has the maximum product. The length of the sublist is irrelevant;
# your job is to maximize the product.
#
# Example
# Input: [ 2, 5, -1, 3 ]
#
# Output: [ 2, 5 ] which gives maximum product 10.

use Modern::Perl;
use List::Util qw( product );

my @n = @ARGV;
my @max_sublist;
my $max_product;

for my $i (0 .. $#n) {
    for my $j ($i .. $#n) {
        my @sublist = @n[$i .. $j];
        my $product = product(@sublist);
        if (!defined($max_product) || $product > $max_product) {
            $max_product = $product;
            @max_sublist = @sublist;
        }
    }
}
say join(", ", @max_sublist);
