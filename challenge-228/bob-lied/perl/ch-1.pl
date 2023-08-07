#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Task 1 Unique Sum 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to find out the sum of unique elements in the given array.
# Example 1 Input: @int = (2, 1, 3, 2)
#           Output: 4
#   In the given array we have 2 unique elements (1, 3).
# Example 2 Input: @int = (1, 1, 1, 1)
#           Output: 0
#   In the given array no unique element found.
# Example 3 Input: @int = (2, 1, 3, 4)
#           Output: 10
#   In the given array every element is unique.
#  
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say uniqueSum(@ARGV);

sub uniqueSum(@list)
{
    my %count;

    my $sum = 0;
    for my $n ( @list )
    {
        my $howMany = ++$count{$n};

        if    ( $howMany == 1 ) { $sum += $n }
        elsif ( $howMany == 2 ) { $sum -= $n }
        # Ignore if present more than twice.
    }
    return $sum;
}

sub runTest
{
    use Test2::V0;

    is( uniqueSum(2,1,3,2),  4, "Example 1");
    is( uniqueSum(1,1,1,1),  0, "Example 2");
    is( uniqueSum(2,1,3,4), 10, "Example 3");

    done_testing;
}
