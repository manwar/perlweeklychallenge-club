#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 262Task 2 Count Equal Divisible
#=============================================================================
# You are given an array of integers, @ints and an integer $k.
# Write a script to return the number of pairs (i, j) where
# a) 0 <= i < j < size of @ints
# b) ints[i] == ints[j]
# c) i x j is divisible by k
#
# Example 1 Input: @ints = (3,1,2,2,2,1,3) and $k = 2
#           Output: 4
#   (0, 6) => ints[0] == ints[6] and 0 x 6 is divisible by 2
#   (2, 3) => ints[2] == ints[3] and 2 x 3 is divisible by 2
#   (2, 4) => ints[2] == ints[4] and 2 x 4 is divisible by 2
#   (3, 4) => ints[3] == ints[4] and 3 x 4 is divisible by 2
# Example 2 Input: @ints = (1,2,3) and $k = 1
#           Output: 0
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say countEqDiv(@ARGV);

sub countEqDiv($k, @ints)
{
    my $count = 0;
    for ( my $i = 0 ; $i < $#ints ; $i++ )
    {
        for ( my $j = $i+1; $j <= $#ints; $j++ )
        {
            $count++ if ( $ints[$i] == $ints[$j] && (($i * $j) % $k == 0) )
        }
    }
    return $count;
}

sub runTest
{
    use Test2::V0;

    is( countEqDiv(2, (3,1,2,2,2,1,3) ), 4, "Example 1");
    is( countEqDiv(1, (1,2,3)         ), 0, "Example 2");

    done_testing;
}
