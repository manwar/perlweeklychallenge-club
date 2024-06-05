#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 272 Task 2 String Score
#=============================================================================
# 
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
    my $first = shift @v;
    while ( @v )
    {
        my $second = shift @v;
        $score += abs($first - $second);
        $first = $second;
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
