#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 238 Task 1  Running Sum
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to return the running sum of the given array. The running
# sum can be calculated as sum[i] = num[0] + num[1] + …. + num[i].
# Example 1 Input: @int = (1, 2, 3, 4, 5)
#           Output: (1, 3, 6, 10, 15)
# Example 2 Input: @int = (1, 1, 1, 1, 1)
#           Output: (1, 2, 3, 4, 5)
# Example 3 Input: @int = (0, -1, 1, 2)
#           Output: (0, -1, 0, 2)
#=============================================================================

use v5.38;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(", ", runningSum(@ARGV)->@*), ")";

sub runningSum(@int)
{
    my @running;
    my $sum = 0;
    push @running, $sum += shift @int while @int;
    return \@running;
}

sub runTest
{
    use Test2::V0;

    is( runningSum(1,2,3,4,5), [1,3,6,10,15], "Example 1");
    is( runningSum(1,1,1,1,1), [1,2,3,4,5  ], "Example 2");
    is( runningSum(0,-1,1,2 ), [0,-1,0,2   ], "Example 3");

    is( runningSum(         ), [           ], "Empty list");
    is( runningSum(9234     ), [ 9234      ], "Singleton");

    done_testing;
}

