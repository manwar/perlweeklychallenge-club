#!/usr/bin/env perl

# Challenge 151
#
# TASK #2 › Rob The House
# Submitted by: Mohammad S Anwar
# You are planning to rob a row of houses, always starting with the first
# and moving in the same direction. However, you can’t rob two adjacent houses.
#
# Write a script to find the highest possible gain that can be achieved.
#
# Example 1:
# Input: @valuables = (2, 4, 5);
# Output: 7
#
# If we rob house (index=0) we get 2 and then the only house we can rob is
# house (index=2) where we have 5.
# So the total valuables in this case is (2 + 5) = 7.
#
# Example 2:
# Input: @valuables = (4, 2, 3, 6, 5, 3);
# Output: 13
#
# The best choice would be to first rob house (index=0) then rob house (index=3) then finally house (index=5).
# This would give us 4 + 6 + 3 =13.

use Modern::Perl;
use List::Util qw( max );

say max_gain(@ARGV);


sub max_gain {
    my(@valuables) = @_;

    my $gain = $valuables[0];       # start with this house
    my $max_next = 0;
    for my $i (2..$#valuables) {
        my $next = max_gain(@valuables[$i .. $#valuables]);
        $max_next = max( $max_next, $next );
    }

    return $gain + $max_next;
}
