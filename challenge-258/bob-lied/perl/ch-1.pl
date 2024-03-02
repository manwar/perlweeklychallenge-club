#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 258 Task 1 Count Even Digits Number
#=============================================================================
# You are given a array of positive integers, @ints.
# Write a script to find out how many integers have even number of digits.
# Example 1 Input: @ints = (10, 1, 111, 24, 1000)
#           Output: 3
# Example 2 Input: @ints = (111, 1, 11111)
#           Output: 0
# Example 3 Input: @ints = (2, 8, 1024, 256)
#           Output: 1
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say cedn( map { s/[^0-9]//gr } @ARGV);

sub cedn(@ints)
{
    return scalar grep { length($_) % 2 == 0 }  @ints;
}

sub runTest
{
    use Test2::V0;

    is(cedn(10, 1, 111, 24, 1000), 3, "Example 1");
    is(cedn(111, 1, 11111),        0, "Example 2");
    is(cedn(2, 8, 1024, 256),      1, "Example 3");

    done_testing;
}
