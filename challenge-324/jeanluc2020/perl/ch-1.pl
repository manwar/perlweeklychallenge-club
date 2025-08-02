#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-324/#TASK1
#
# Task 1: 2D Array
# ================
#
# You are given an array of integers and two integers $r amd $c.
#
# Write a script to create two dimension array having $r rows and $c columns
# using the given array.
#
## Example 1
##
## Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
## Output: ([1, 2], [3, 4])
#
#
## Example 2
##
## Input: @ints = (1, 2, 3), $r = 1, $c = 3
## Output: ([1, 2, 3])
#
#
## Example 3
##
## Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
## Output: ([1], [2], [3], [4])
#
############################################################
##
## discussion
##
############################################################
#
# We just loop over the amount of rows and over the amount
# of columns, constructing the rows by creating the elements
# for it, and then in the end we have our result.
# If there are not enough elements in the input array, we return
# right away. If there are more elements in the array than are
# required, we just skip the remaining elements in the input
# array.

use v5.36;

twod_array( [1, 2, 3, 4], 2, 2 );
twod_array( [1, 2, 3], 1, 3 );
twod_array( [1, 2, 3, 4], 4, 1 );
twod_array( [1, 2, 3], 2, 2 );
twod_array( [1, 2, 3, 4, 5], 2, 2 );

sub twod_array( $ints, $r, $c ) {
    say "Input: [" . join(", ", @$ints) . "], $r, $c";
    my @result = ();
    if(scalar(@$ints) < $r * $c) {
        return say "Not enough elements in array!";
    }
    foreach my $i (0..$r-1) {
        my @tmp = ();
        foreach my $j (0..$c-1) {
            push @tmp, shift @$ints;
        }
        push @result, [ @tmp ];
    }

    print "Output: [";
    foreach my $elem (@result) {
        print "[" . join(", ", @$elem) . "], ";
    }
    say "]";
}

