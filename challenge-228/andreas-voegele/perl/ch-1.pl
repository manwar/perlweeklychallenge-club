#!/usr/bin/perl

# You are given an array of integers.  Write a script to find out the sum of
# unique elements in the given array.  Non-unique elements are ignored.

use 5.036;
use utf8;

use List::Util qw(sum0);

sub unique_sum (@ints) {
    my %count_for;
    for (@ints) {
        ++$count_for{$_};
    }
    return sum0 grep { $count_for{$_} == 1 } @ints;
}

say unique_sum(2, 1, 3, 2);
say unique_sum(1, 1, 1, 1);
say unique_sum(2, 1, 3, 4);
