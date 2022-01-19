#!/usr/bin/perl

# Challenge 145
#
# TASK #1 > Dot Product
# Submitted by: Mohammad S Anwar
# You are given 2 arrays of same size, @a and @b.
#
# Write a script to implement Dot Product.
#
# Example:
# @a = (1, 2, 3);
# @b = (4, 5, 6);
#
# $dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32

use Modern::Perl;

sub dot_product {
    my(@ab) = @_;
    my $n = int(@ab/2);
    my $p = 0;
    for my $i (0..$n-1) {
        $p += $ab[$i]*$ab[$n+$i];
    }
    return $p;
}

say dot_product(@ARGV);
