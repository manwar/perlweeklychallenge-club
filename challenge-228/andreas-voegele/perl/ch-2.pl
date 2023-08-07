#!/usr/bin/perl

# You are given an array of integers in which all elements are unique.  Write
# a script to perform the following operations until the array is empty and
# return the total count of operations.
#
# If the first element is the smallest then remove it otherwise move it to the
# end.

use 5.036;
use utf8;

sub empty_array (@ints) {
    my $count = 0;
    my @mins  = sort { $a <=> $b } @ints;
    while (@ints > 0) {
        ++$count;
        my $first = shift @ints;
        if (@ints > 0) {
            if ($first > $mins[0]) {
                push @ints, $first;
            }
            else {
                shift @mins;
            }
        }
    }
    return $count;
}

say empty_array(3, 4, 2);
say empty_array(1, 2, 3);
