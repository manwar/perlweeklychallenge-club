#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 291 Task 1 Middle Index
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to find the leftmost middle index (MI) i.e. the smallest
# amongst all the possible ones.
# A middle index is an index where
#   ints[0] + ints[1] + … + ints[MI-1] ==
#   ints[MI+1] + ints[MI+2] + … + ints[ints.length-1]
# If MI == 0, the left side sum is considered to be 0. Similarly,
# if MI == ints.length - 1, the right side sum is considered to be 0.
# Return the leftmost MI that satisfies the condition, or -1 if there is
# no such index.
#
# Example 1 Input: @ints = (2, 3, -1, 8, 4)
#           Output: 3
#   The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
#   The sum of the numbers after index 3 is: 4 = 4
# Example 2 Input: @ints = (1, -1, 4)
#           Output: 2
#   The sum of the numbers before index 2 is: 1 + -1 = 0
#   The sum of the numbers after index 2 is: 0
# Example 3 Input: @ints = (2, 5)
#           Output: -1
#=============================================================================

use v5.40;
use List::Util qw/sum/;

use Getopt::Long;
my $DoTest  = false;

GetOptions("test" => \$DoTest);
exit(!runTest()) if $DoTest;

say stuckInTheMiddle(@ARGV);    # I'm wondering how I'll get down the stairs

sub stuckInTheMiddle(@circus)
{
    my $clowns = 0;             # Clowns to the left of me
    my $jokers = sum(@circus);  # Jokers to the right

    for my $middle (0 ... $#circus)
    {
        my $me = $circus[$middle];  # Here I am
                                    # Stuck in the middle with you
        return $middle if $clowns == $jokers - $me;

        $clowns += $me;   # Well you started out with nothing
        $jokers -= $me;   # And you're proud that you're a self-made man
    }
    return -1;  # But I can see it makes no sense at all
}

sub runTest
{
    use Test2::V0;

    is( stuckInTheMiddle(2, 3, -1, 8, 4), 3, "Example 1");
    is( stuckInTheMiddle(1, -1, 4),       2, "Example 2");
    is( stuckInTheMiddle(2, 5),          -1, "Example 3");

    is( stuckInTheMiddle(7), 0, "Singleton");

    done_testing;
}
