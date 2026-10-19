#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-396/#TASK1
#
# Task 1: Finishing Order
# =======================
#
# You are given two array of integers, @order and @friends.
#
# The @order (size n) contains every integer from 1 to n exactly once. The
# @friends contains ID in sorted in strictly increasing order.
#
# Write a script to return the array containing IDs in finishing order.
#
## Example 1
##
## Input: @order = (3, 1, 4, 2, 5)
##        @friends = (1, 2, 4)
## Output: (1, 4, 2)
##
## ID 1 finished 2nd.
## ID 4 finished 3rd.
## ID 2 finished 4th.
#
## Example 2
##
## Input: @order = (5, 4, 3, 2, 1)
##        @friends = (1, 3, 5)
## Output: (5, 3, 1)
##
## ID 5 finished 1st.
## ID 3 finished 3rd.
## ID 1 finished 5th.
#
## Example 3
##
## Input: @order = (2, 4, 1, 3)
##        @friends = (1, 2, 3, 4)
## Output: (2, 4, 1, 3)
##
## ID 2 finished 1st.
## ID 4 finished 2nd.
## ID 1 finished 3rd.
## ID 3 finished 4th.
#
## Example 4
##
## Input: @order = (4, 1, 3, 2)
##        @friends = (3)
## Output: (3)
#
## Example 5
##
## Input: @order = (1, 3, 2, 6, 5, 4)
##        @friends = (1, 2, 3)
## Output: (1, 3, 2)
##
## ID 1 finished 1st.
## ID 3 finished 2nd.
## ID 2 finished 3rd.
#
############################################################
##
## discussion
##
############################################################
#
# Since the order is given by @order, we just fill a hash with the index
# for the order and use that hash to sort the @friends.

use v5.36;

sub finishing_order($order, $friends) {
    say "Input: (" . join(", ", @$order) . "), (" . join(", ", @$friends) . ")";
    my $idx = 0;
    my $ordered = {};
    foreach my $elem (@$order) {
        $idx++;
        $ordered->{$elem} = $idx;
    }
    say "Output: (" . join(", ", sort { $ordered->{$a} <=> $ordered->{$b} } @$friends) . ")";
}

finishing_order( [3, 1, 4, 2, 5], [1, 2, 4]);
finishing_order( [5, 4, 3, 2, 1], [1, 3, 5]);
finishing_order( [2, 4, 1, 3], [1, 2, 3, 4]);
finishing_order( [4, 1, 3, 2], [3]);
finishing_order( [1, 3, 2, 6, 5, 4], [1, 2, 3]);
