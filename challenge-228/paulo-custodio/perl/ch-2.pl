#!/usr/bin/env perl

# Challenge 228
#
# Task 2: Empty Array
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers in which all elements are unique.
#
# Write a script to perform the following operations until the array is empty and return the total count of operations.
#
# If the first element is the smallest then remove it otherwise move it to the end.
#
#
# Example 1
#
# Input: @int = (3, 4, 2)
# Ouput: 5
#
# Operation 1: move 3 to the end: (4, 2, 3)
# Operation 2: move 4 to the end: (2, 3, 4)
# Operation 3: remove element 2: (3, 4)
# Operation 4: remove element 3: (4)
# Operation 5: remove element 4: ()
#
# Example 2
#
# Input: @int = (1, 2, 3)
# Ouput: 3
#
# Operation 1: remove element 1: (2, 3)
# Operation 2: remove element 2: (3)
# Operation 3: remove element 3: ()

use Modern::Perl;
use List::Util 'min';

my @ints = @ARGV;
say count_ops(@ints);

sub count_ops {
    my(@ints) = @_;
    my $ops = 0;
    while (@ints) {
        if (min(@ints)==$ints[0]) {
            shift @ints;
        }
        else {
            push @ints, shift @ints;
        }
        $ops++;
    }
    return $ops;
}
