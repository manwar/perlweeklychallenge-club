#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 240 Task 2 Build Array
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to create an array such that new[i] = old[old[i]]
# where 0 <= i < new.length.
# Example 1 Input: @int = (0, 2, 1, 5, 3, 4)
#           Output: (0, 1, 2, 4, 5, 3)
# Example 2 Input: @int = (5, 0, 1, 2, 3, 4)
#           Output: (4, 5, 0, 1, 2, 3)
#=============================================================================

use v5.38;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(", ", buildArray(@ARGV)->@*), ")";

sub buildArray(@int)
{

    return [ @int[@int] ];
}

sub runTest
{
    use Test2::V0;

    is( buildArray(0,2,1,5,3,4), [0,1,2,4,5,3],  "Example 1");
    is( buildArray(5,0,1,2,3,4), [4,5,0,1,2,3],  "Example 2");

    done_testing;
}
