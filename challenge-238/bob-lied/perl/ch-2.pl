#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 238 Task 2 Persistence Sort 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of positive integers.
# Write a script to sort the given array in increasing order with respect to
# the count of steps required to obtain a single-digit number by multiplying
# its digits recursively for each array element. If any two numbers have the
# same count of steps, then print the smaller number first.
# Example 1 Input: @int = (15, 99, 1, 34)
#           Output: (1, 15, 34, 99)
#   15 => 1 x 5 => 5 (1 step)
#   99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
#   1  => 0 step
#   34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)
#
# Example 2 Input: @int = (50, 25, 33, 22)
#           Output: (22, 33, 50, 25)
#   50 => 5 x 0 => 0 (1 step)
#   25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
#   33 => 3 x 3 => 6 (1 step)
#   22 => 2 x 2 => 4 (1 step)
#=============================================================================

use v5.38;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(", ",  persistenceSort(@ARGV)->@*), ")";

# Product of digits, treating the number as a string
sub r2d($n)
{
use List::Util qw/product/;
    my $step = 0;
    while ( $n > 9 )
    {
        ++$step;
        $n = product split(//, $n);
    }
    return $step;
}

# Product of digits, pure arithmetic
sub reduceToDigit($n)
{
    my $step = 0;
    while ( $n > 9 )
    {
        $step++;
        my $p = 1;
        while ( $n )
        {
            $p *= $n % 10;
            $n = int($n/10);
        }
        $n = $p;
    }
    return $step;
}

# Schwartzian transform
#  -- convert each input into a [value, stepcount] pair
#  -- Sort by the step count, and then the value
#  -- Drop the step count from each pair in the sorted list
sub persistenceSort(@int)
{
    return [ map { $_->[0] }
        sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[1] }
        map { [ $_, reduceToDigit($_) ] } @int ];
}

sub runTest
{
    use Test2::V0;

    is( reduceToDigit(0), 0, "reduce: 0");
    is( reduceToDigit(1), 0, "reduce: 1");
    is( reduceToDigit(10+$_), 1, "reduce: 1$_") for 0..9;
    is( reduceToDigit(10*$_), 1, "reduce: ${_}0") for 1..9;
    is( reduceToDigit(99), 2, "reduce: 99");
    is( reduceToDigit(34), 2, "reduce: 34");
    is( reduceToDigit(50), 1, "reduce: 50");
    is( reduceToDigit(25), 2, "reduce: 25");
    is( reduceToDigit(33), 1, "reduce: 33");
    is( reduceToDigit(22), 1, "reduce: 22");
    is( reduceToDigit(8432), 3, "reduce 8432");

    is( persistenceSort(15,99,1,34),  [1,15,34,99 ], "Example 1");
    is( persistenceSort(50,25,33,22), [22,33,50,25], "Example 2");

    is( persistenceSort( ),  [ ], "Empty list");
    is( persistenceSort(5),  [5], "Single digit");
    is( persistenceSort(36), [36], "Single number");

    done_testing;
}
