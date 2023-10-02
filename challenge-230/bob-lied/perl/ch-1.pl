#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Task 1 Separate Digits 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of positive integers.
# Write a script to separate the given array into single digits.
# Example 1 Input: @ints = (1, 34, 5, 6)
#           Output: (1, 3, 4, 5, 6)
# Example 2 Input: @ints = (1, 24, 51, 60)
#           Output: (1, 2, 4, 5, 1, 6, 0)
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(", ", separateDigits(@ARGV)->@*), ")";

sub separateDigits(@list)
{
    return [ map { split(//, $_) } @list ];
}

sub runTest
{
    use Test2::V0;

    is( separateDigits(1,34,5,6),   [1,3,4,5,6], "Example 1");
    is( separateDigits(1,24,51,60), [1,2,4,5,1,6,0], "Example 2");

    done_testing;
}
