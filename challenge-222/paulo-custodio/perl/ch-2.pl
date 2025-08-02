#!/usr/bin/env perl

# Challenge 222
#
# Task 2: Last Member
# Submitted by: Mohammad S Anwar
# You are given an array of positive integers, @ints.
#
# Write a script to find the last member if found otherwise return 0. Each turn
# pick 2 biggest members (x, y) then decide based on the following conditions,
# continue this until you are left with 1 member or none.
#
# a) if x == y then remove both members
#
# b) if x != y then remove both members and add new member (y-x)
#
#
# Example 1:
# Input: @ints = (2, 7, 4, 1, 8, 1)
# Output: 1
#
# Step 1: pick 7 and 8, we remove both and add new member 1 => (2, 4, 1, 1, 1).
# Step 2: pick 2 and 4, we remove both and add new member 2 => (2, 1, 1, 1).
# Step 3: pick 2 and 1, we remove both and add new member 1 => (1, 1, 1).
# Step 4: pick 1 and 1, we remove both => (1).
# Example 2:
# Input: @ints = (1)
# Output: 1
# Example 3:
# Input: @ints = (1, 1)
# Output: 0
#
# Step 1: pick 1 and 1, we remove both and we left with none.

use Modern::Perl;

my @ints = @ARGV;
say last_member(@ints);

sub last_member {
    my(@ints) = @_;
    for (;;) {
        return 0 if @ints==0;
        return $ints[0] if @ints==1;
        @ints = sort {$a <=> $b} @ints;
        my $y = pop @ints;
        my $x = pop @ints;
        if ($x != $y) {
            push @ints, $y-$x;
        }
    }
}
