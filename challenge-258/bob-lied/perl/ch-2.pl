#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 258 Task 2 Sum of Values
#=============================================================================
# You are given an array of integers, @int and an integer $k.
# Write a script to find the sum of values whose index binary
# representation has exactly $k number of 1-bit set.
# Example 1 Input: @ints = (2, 5, 9, 11, 3), $k = 1
#           Output: 17
#   Binary representation of index 0 = 0
#   Binary representation of index 1 = 1
#   Binary representation of index 2 = 10
#   Binary representation of index 3 = 11
#   Binary representation of index 4 = 100
#   So the indices 1, 2 and 4 have total one 1-bit sets.
#   Therefore the sum, $ints[1] + $ints[2] + $ints[4] = 17
# Example 2 Input: @ints = (2, 5, 9, 11, 3), $k = 2
#           Output: 11
# Example 3 Input: @ints = (2, 5, 9, 11, 3), $k = 0
#           Output: 2
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $K = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "k:i" => \$K);
exit(!runTest()) if $DoTest;

say sumOfVal($K, @ARGV);

sub hasKones($k, $n)
{
    return ( sprintf("%b", $n) =~ tr/1/1/) == $k;
}

sub sumOfVal($k, @ints)
{
    use List::Util qw/sum0/;

    return sum0( @ints[ grep { hasKones($k, $_) } 0 .. $#ints ] );
}

sub runTest
{
    use Test2::V0;
    use builtin qw/true false/; no warnings "experimental::builtin";

    is( hasKones(1, 0), false, "k ones 1 0");
    is( hasKones(1, 4), true,  "k ones 1 4");
    is( hasKones(2, 5), true,  "k ones 2 5");
    is( hasKones(1, 6), false, "k ones 1 6");
    is( hasKones(2, 6), true,  "k ones 2 6");
    is( hasKones(2, 7), false, "k ones 2 7");
    is( hasKones(1, 8), true,  "k ones 1 8");
    is( hasKones(2, 8), false, "k ones s 8");
    is( hasKones(3, 8), false, "k ones 3 8");

    is( sumOfVal(1, (2,5,9,11,3)), 17, "Example 1");
    is( sumOfVal(2, (2,5,9,11,3)), 11, "Example 2");
    is( sumOfVal(0, (2,5,9,11,3)),  2, "Example 3");

    done_testing;
}
