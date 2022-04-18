#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

# TASK #2 › Equilibrium Index
# Submitted by: Mohammad S Anwar
#
# You are give an array of integers, @n.
#
# Write a script to find out the Equilibrium Index of the given array, if found.
#
#     For an array A consisting n elements, index i is an equilibrium index if the sum of elements of subarray A[0…i-1] is equal to the sum of elements of subarray A[i+1…n-1].
#
#
# Example 1:
#
# Input: @n = (1, 3, 5, 7, 9)
# Output: 3
#
#
# Example 2:
#
# Input: @n = (1, 2, 3, 4, 5)
# Output: -1 as no Equilibrium Index found.
#
#
# Example 3:
#
# Input: @n = (2, 4, 2)
# Output: 1

use List::Util qw(all sum0);
use Scalar::Util qw(looks_like_number);

run() unless caller();

sub run() {
    my @xs = @ARGV;
    die "Expect a list of integers!\n" unless all { m/^-?\d+$/ } @xs;

    say equilibrium_index(@xs);
}

sub equilibrium_index(@xs) {
    for my $i ( 0 .. $#xs  ) {
        my $lower = sum0( @xs[ 0 .. $i - 1 ] );
        my $upper = sum0( @xs[ $i + 1 .. $#xs ] );
        return $i if $lower == $upper;
    }

    return -1;
}
