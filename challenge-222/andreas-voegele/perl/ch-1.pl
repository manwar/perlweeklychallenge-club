#!/usr/bin/perl

# You are given a list of positive integers, @ints.  Write a script to find
# the total matching members after sorting the list in increasing order.

use 5.036;
use utf8;

use List::Util qw(zip);

sub matching_members (@ints) {
    return map { $_->[0] } grep { $_->[0] == $_->[1] } zip \@ints,
        [sort { $a <=> $b } @ints];
}

say scalar matching_members(1, 1, 4, 2, 1, 3);
say scalar matching_members(5, 1, 2, 3, 4);
say scalar matching_members(1, 2, 3, 4, 5);
