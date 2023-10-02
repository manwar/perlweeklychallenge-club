#!/usr/bin/perl

# You are given an array of positive integers, @ints.  Write a script to find
# the last member if found otherwise return 0.  Each turn pick the two biggest
# members (x, y) then decide based on the following conditions, continue this
# until you are left with one member or none.
#
# a) if x == y then remove both members
#
# b) if x != y then remove both members and add new member (y - x)

use 5.036;
use utf8;

sub last_member (@ints) {
    my @sorted_ints = sort { $b <=> $a } @ints;
    my ($x, $y) = splice @sorted_ints, 0, 2;
    if (defined $x) {
        if (defined $y) {
            my $delta = abs $y - $x;
            if ($delta != 0) {
                push @sorted_ints, $delta;
            }
            return last_member(@sorted_ints);
        }
        return $x;
    }
    return 0;
}

say last_member(2, 7, 4, 1, 8, 1);
say last_member(1);
say last_member(1, 1);
