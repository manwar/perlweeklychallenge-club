#!/usr/bin/env raku

=begin pod

Week 186:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-186

Task #1: Zip List

    You are given two list @a and @b of same size.

    Create a subroutine sub zip(@a, @b) that merge the two list.

=end pod

use Test;

my @a = (1, 2, 3);
my @b = ('a', 'b', 'c');

is [ zip(@a, @b) ], [1, 'a', 2, 'b', 3, 'c' ], 'Example 1';
is [ zip(@b, @a) ], ['a', 1, 'b', 2, 'c', 3 ], 'Example 2';

done-testing;

#
#
# METHOD

sub zip(@a, @b) {
    my @zip = (@a Z @b);
    return @zip;
}
