#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-1.pl Perl Weekly Challenge 252 Task 1 Special Numbers
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to find the sum of the squares of all special elements of
# the given array.  An element $int[i] of @ints is called special if
# i divides n, i.e. n % i == 0.  Where n is the length of the given array.
# Also the array is 1-indexed for the task.
# Example 1 Input: @ints = (1, 2, 3, 4)
#           Output: 21
#   There are exactly 3 special elements in the given array:
#   $ints[1] since 1 divides 4,
#   $ints[2] since 2 divides 4, and
#   $ints[4] since 4 divides 4.
#   Hence, the sum of the squares of all special elements of given array:
#   1 * 1 + 2 * 2 + 4 * 4 = 21.
# Example 2 Input: @ints = (2, 7, 1, 19, 18, 3)
#           Output: 63
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";
use List::Util qw/sum0/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub specialNumbers(@ints)
{
    my $len = @ints;
    # Insert an extra element at the front to make it 1-indexed
    unshift @ints, $len+1;

    return sum0 map { $_ * $_ } @ints[ grep { $len % $_ == 0 } 1 .. $len ];
}

sub factorsOf($n)
{
    use List::Util qw/uniqint/;
    my @flist = (1, $n);
    for my $f ( 2 .. int(sqrt($n)) )
    {
        push @flist, ($f, $n/$f) if $n % $f == 0;
    }
    return [ uniqint sort { $a <=> $b } @flist ]
}

sub sn2(@ints)
{
    use List::MoreUtils qw/before/;
    my $len = @ints;
    return 0 if $len == 0;
    my @choose = map { $_ - 1 } before { $_ > $len } factorsOf($len)->@*;
    return sum0 map { $_ * $_ } @ints[@choose];
}

sub runTest
{
    use Test2::V0;

    is( specialNumbers(1,2,3,4),       21, "Example 1");
    is( specialNumbers(2,7,1,19,18,3), 63, "Example 2");
    is( specialNumbers(8            ), 64, "Singleton");
    is( specialNumbers()            ,   0, "Empty list");

    is( sn2(1,2,3,4),       21, "sn2 Example 1");
    is( sn2(2,7,1,19,18,3), 63, "sn2 Example 2");
    is( sn2(8            ), 64, "sn2 Singleton");
    is( sn2()            ,   0, "sn2 Empty list");

    is( factorsOf( 6), [1,2,3,6], "factorsOf 6");
    is( factorsOf(36), [1,2,3,4,6,9,12,18,36], "factorsOf 36");

    done_testing;
}
