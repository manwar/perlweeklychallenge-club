#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Left Right Sum Diff 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to return left right sum diff array as shown below:
#   @ints = (a, b, c, d, e)
#   @left  = (0, a, (a+b), (a+b+c), (a+b+c+d))
#   @right = ((b+(c+d+e), (d+e), e, 0)
#   @left_right_sum_diff = ( | 0         - (b+c+d+e) |,
#                            | a         - (c+d+e)   |,
#                            | (a+b)     - (d+e)   |,
#                            | (a+b+c)   - e |,
#                            | (a+b+c+d) - 0 | )
######
# This is kind of an awkward description of the problem. Another way to look
# at it is that, for every index k, there is a sum of the elements to the
# left, and a sum of the elements to the right. We want a vector of the
# differences at each k. At the edges, for k=1, left=0; and for k=n, right=0.
# _________________________________________
# |1| <--left-sum--  |k| --right-sum--> |n|
# -----------------------------------------
######
#
# Example 1: Input: @ints = (10, 4, 8, 3)
#           Output: (15, 1, 11, 22)
#   @left  = (0, 10, 14, 22)
#   @right = (15, 11, 3, 0)
#   @left_right_sum_diff = ( |0-15|, |10-11|, |14-3|, |22-0|)
#                          = (15, 1, 11, 22)
# Example 2: Input: @ints = (1)
#           Output: (0)
#   @left  = (0)
#   @right = (0)
#   @left_right_sum_diff = ( |0-0| ) = (0)
#
# Example 3: Input: @ints = (1, 2, 3, 4, 5)
#           Output: (14, 11, 6, 1, 10)
#   @left  = (0, 1, 3, 6, 10)
#   @right = (14, 12, 9, 5, 0)
#   @left_right_sum_diff = ( |0-14|, |1-12|, |3-9|, |6-5|, |10-0|)
#                        = (14, 11, 6, 1, 10)
#=============================================================================

use v5.36;

use List::Util qw/sum0/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(", ", lrsd(@ARGV)->@*), ")";

sub lrsd(@ints)
{
    my $left = 0;
    my $right = sum0(@ints);

    # Accumulate the differences in this array.  Pre-allocate to be the
    # same size as the input array.
    my @diff; $#diff = $#ints;

    # Walk the array. At each step, add a term to the left sum
    # and subtract a term from the right sum.
    for my $i ( 0 .. $#ints )
    {
        $right -= $ints[$i];
        $diff[$i] = abs($left - $right);
        $left += $ints[$i];
    }
    return \@diff;
}

sub runTest
{
    use Test2::V0;

    is( lrsd(10,4,8,3 ), [ 15,  1, 11, 22     ], "Example 1");
    is( lrsd(1        ), [  0                 ], "Example 2");
    is( lrsd(1,2,3,4,5), [ 14, 11,  6,  1, 10 ], "Example 3");

    done_testing;
}
