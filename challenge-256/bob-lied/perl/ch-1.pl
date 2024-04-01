#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 256 Task 1 Maximum Pairs
#=============================================================================
# You are given an array of distinct words, @words.
# Write a script to find the maximum pairs in the given array. The
# words $words[i] and $words[j] can be a pair one is reverse of the other.
# Example 1 Input: @words = ("ab", "de", "ed", "bc")
#           Output: 1
#   There is one pair in the given array: "de" and "ed"
# Example 2 Input: @words = ("aa", "ba", "cd", "ed")
#           Output: 0
# Example 3 Input: @words = ("uv", "qp", "st", "vu", "mn", "pq"))
#           Output: 2
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say maxPair(@ARGV);

sub maxPair(@words)
{
    my $pairCount = 0;
    while ( defined(my $one = shift @words) )
    {
        for my $two ( @words )
        {
            do { $pairCount++; last } if $one eq reverse($two);
        }
    }
    return $pairCount;
}

sub runTest
{
    use Test2::V0;

    is( maxPair( qw(ab de ed  bc     ) ), 1, "Example 1");
    is( maxPair( qw(aa ba cd ed      ) ), 0, "Example 2");
    is( maxPair( qw(uv qp st vu mn pq) ), 2, "Example 3");

    done_testing;
}
