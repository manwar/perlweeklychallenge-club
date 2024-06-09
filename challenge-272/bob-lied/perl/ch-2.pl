#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 272 Task 2 String Score
#=============================================================================
# You are given a string, $str.
# Write a script to return the score of the given string.
# The score of a string is defined as the sum of the absolute difference
# between the ASCII values of adjacent characters.
# Example 1 Input: $str = "hello"
#           Output: 13
#   ASCII values of characters: h=104 e=101 l=108 l=108 o=111
#   Score => |104 - 101| + |101 - 108| + |108 - 108| + |108 - 111|
#         => 3 + 7 + 0 + 3 => 13
# Example 2 Input: "perl"
#           Output: 30
# #xample 3 Input: "raku"
#           Output: 37
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say stringScore($_) for @ARGV;

sub stringScore($str)
{
    my @v = map { ord($_) } split(//, $str);

    my $score = 0;

    for ( my $first = shift @v ; defined(my $second = shift @v) ; $first = $second )
    {
        $score += abs($first - $second);
    }

    return $score;
}

sub runTest
{
    use Test2::V0;

    is( stringScore("hello"), 13, "Example 1");
    is( stringScore("perl"),  30, "Example 2");
    is( stringScore("raku"),  37, "Example 3");

    is( stringScore(""),  0, "Empty string");
    is( stringScore("R"), 0, "length 1 string");
    is( stringScore("LLL"), 0, "repeated letters");

    done_testing;
}
