#!/usr/bin/env perl

# Challenge 112
#
# TASK #2 - Climb Stairs
# Submitted by: Mohammad S Anwar
# You are given $n steps to climb
#
# Write a script to find out the distinct ways to climb to the top. You are
# allowed to climb either 1 or 2 steps at a time.
#
# Example
# Input: $n = 3
# Output: 3
#
#     Option 1: 1 step + 1 step + 1 step
#     Option 2: 1 step + 2 steps
#     Option 3: 2 steps + 1 step
#
# Input: $n = 4
# Output: 5
#
#     Option 1: 1 step + 1 step + 1 step + 1 step
#     Option 2: 1 step + 1 step + 2 steps
#     Option 3: 2 steps + 1 step + 1 step
#     Option 4: 1 step + 2 steps + 1 step
#     Option 5: 2 steps + 2 steps

use Modern::Perl;

my $n = shift || 0;
say count($n);

sub count {
    my($n) = @_;
    if ($n <= 0) {
        return 0;
    }
    elsif ($n == 1) {
        return 1;
    }
    elsif ($n == 2) {
        return 2;
    }
    else {
        return count($n-1)+count($n-2);
    }
}
