#!/usr/bin/perl

=head1

Week 192:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-192

Task #1: Binary Flip

    You are given a positive integer, $n.

    Write a script to find the binary flip.

=cut

use v5.36;
use Test2::V0;

is binary_flip(5), 2, 'Example 1';
is binary_flip(4), 3, 'Example 2';
is binary_flip(6), 1, 'Example 3';

done_testing;

#
#
# METHOD

sub binary_flip($n) {
    return oct   '0b'.
           join  q{},
           map   { tr/10/01/ and $_ }
           split //,sprintf '%b', $n;
}
