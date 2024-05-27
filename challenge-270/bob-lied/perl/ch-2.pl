#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 270 Task 2 Equalize Array
#=============================================================================
# You are give an array of integers, @ints and two integers, $x and $y.
# Write a script to execute one of the two options:
# Level 1: Pick an index i of the given array and do $ints[i] += 1
# Level 2: Pick two different indices i,j and do $ints[i] +=1 and $ints[j] += 1.
# You are allowed to perform as many levels as you want to make every elements
# in the given array equal. There is cost attach for each level, for Level 1,
# the cost is $x and $y for Level 2.
# In the end return the minimum cost to get the work done.
#
# Example 1 Input: @ints = (4, 1), $x = 3 and $y = 2
#           Output: 9
#   Level 1: i=1, so $ints[1] += 1.  @ints = (4, 2)
#   Level 1: i=1, so $ints[1] += 1.  @ints = (4, 3)
#   Level 1: i=1, so $ints[1] += 1.  @ints = (4, 4)
#   We performed operation Level 1 three times,
#   so the total cost would be 3 x $x => 3 x 3 => 9
#
# Example 2 Input: @ints = (2, 3, 3, 3, 5), $x = 2 and $y = 1
#           Output: 6
#   Level 2: i=0, j=1, $ints[0]++ and $ints[1]++, @ints = (3, 4, 3, 3, 5)
#   Level 2: i=0, j=2, $ints[0]++ and $ints[2]++, @ints = (4, 4, 4, 3, 5)
#   Level 2: i=0, j=3, $ints[0]++ and $ints[3]++, @ints = (5, 4, 4, 4, 5)
#   Level 2: i=1, j=2, $ints[1]++ and $ints[2]++, @ints = (5, 5, 5, 4, 5)
#   Level 1: i=3, so $ints[3] += 1                @ints = (5, 5, 5, 5, 5)
#   We perforned operation Level 1 one time and Level 2 four times.
#   So the total cost would be (1 x $x) + (4 x $y) => (1 x 2) + (4 x 1) => 6
#=============================================================================

use v5.38;

use List::Util qw/max sum/;

use Getopt::Long;
my $X; my $Y;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "x:i" => \$X, "y:i" => \$Y);
exit(!runTest()) if $DoTest;

say equalizeArray(\@ARGV, $X, $Y);

sub equalizeArray($ints, $lvl1cost, $lvl2cost)
{
    if ( $ints->$#* < 1 )
    {
        # Nothing to add to, no moves possible
        return 0;
    }
    elsif ( $ints->$#* == 1 )
    {
        # Only Level 1 moves are possible.
        return abs($ints->[1] - $ints->[0]) * $lvl1cost;
    }

    my @list = sort { $b <=> $a } $ints->@*;
    my $target = shift @list;

    if ( $lvl2cost > (2 * $lvl1cost) )
    {
        # Cheaper to do all single moves
        my $addsNeeded = sum map { $target - $_ } $ints->@*;
        return $lvl1cost * $addsNeeded;
    }

    my $cost = 0;
    while ( @list )
    {
        # Delete elements that have reached the target.
        shift @list while @list && $list[0] == $target;

        if ( scalar(@list) == 0 )
        {
            return $cost;
        }
        elsif ( scalar(@list) == 1 )
        {
            # Only level 1 moves are still possible.
            return $cost + $lvl1cost * ( $target - $list[0] );

        }

        # Do a level2 move on the first two elements
        $list[0]++; $list[1]++;
        $cost += $lvl2cost;
    }
    return $cost;
}

sub bestCost($ints, $lvl1cost, $lvl2cost)
{
    my $target = max $ints->@*;
    my $addsNeeded = sum map { $target - $_ } $ints->@*;

    if ( $ints->$#* < 1 )
    {
        # Nothing to add to, no moves possible
        return 0;
    }
    elsif ( $ints->$#* == 1 )
    {
        # Only Level 1 moves are possible.
        return $addsNeeded * $lvl1cost;
    }

    if ( $lvl2cost <= 2 * $lvl1cost )
    {
        # Increment 2 at a time as long as we can
        my $cost  = $lvl2cost * int( $addsNeeded / 2 );
        $cost += $lvl1cost if $addsNeeded % 2;
        return $cost;
    }
    else
    {
        # Cheaper just to Level 1 moves
        return $addsNeeded * $lvl1cost;
    }
}

sub runTest
{
    use Test2::V0;

    is( equalizeArray([4,1],       3, 2),  9, "Example 1");
    is( equalizeArray([2,3,3,3,5], 2, 1),  6, "Example 2");
    is( equalizeArray([2,4,3,3,5], 2, 1),  7, "Example 2a");

    is( equalizeArray([5],         3, 2),  0, "No moves");
    is( equalizeArray([ ],         3, 2),  0, "Empty list");

    is( equalizeArray([4,1,1],     3, 9), 18, "Expensive level 2");
    is( equalizeArray([4,1,1],     3, 6), 18, "lvl2 = 2 * lvl1");


    is( equalizeArray([20,1,1],    3, 4), 19*4, "All level 2 moves");
    is( equalizeArray([20,19,1],   3, 5), 1*5 + 18*3, "Only one lvl2, then fill");

    done_testing;
}
