#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 301 Task 2 Hamming Distance
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to return the sum of Hamming distances between all the
# pairs of the integers in the given array of integers.
# The Hamming distance between two integers is the number of places in
# which their binary representations differ.
# Example 1 Input: @ints = (4, 14, 2) Output: 6
#   Binary representation: 4  => 0100 14 => 1110 2  => 0010
#   HammingDistance(4, 14)  # 2
# + HammingDistance(4, 2)   # 2
# + HammingDistance(14, 2)  # 2
#
# Example 2 Input: @ints = (4, 14, 4) Output: 4
#=============================================================================

use v5.40;


use Getopt::Long;
my $DoTest  = false;

GetOptions("test" => \$DoTest);
exit(!runTest()) if $DoTest;

say hammingDistance(@ARGV);

sub hammingDistance(@ints)
{
    my $distance = 0;
    while ( defined(my $first = shift @ints) )
    {
        for my $second ( @ints )
        {
            $distance += hamming($first, $second);
        }
    }
    return $distance;
}

sub hamming($n, $m)
{
    return unpack '%b*', (pack 'i', ($n ^ $m));
}

sub runTest
{
    use Test2::V0;

    is( hammingDistance(4,14,2), 6, "Example 1");
    is( hammingDistance(4,14,4), 4, "Example 2");

    done_testing;
}
