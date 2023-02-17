#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 203 Task 1 Special Quadruplets
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to find out the total special quadruplets for the given array.
# Special Quadruplets are such that satisfies the following 2 rules.
# 1) nums[a] + nums[b] + nums[c] == nums[d]
# 2) a < b < c < d
# Example 1 Input: @nums = (1,2,3,6) Output: 1
#   Since the only special quadruplets found is
#   $nums[0] + $nums[1] + $nums[2] == $nums[3].
# Example 2 Input: @nums = (1,1,1,3,5) Output: 4
#   $nums[0] + $nums[1] + $nums[2] == $nums[3]
#   $nums[0] + $nums[1] + $nums[3] == $nums[4]
#   $nums[0] + $nums[2] + $nums[3] == $nums[4]
#   $nums[1] + $nums[2] + $nums[3] == $nums[4]
# Example 3 Input: @nums = (3,3,6,4,5) Output: 0
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say quad(\@ARGV);

sub quad($nums)
{
    my $howMany = 0;
    my @quad;
    my $end = $#{$nums};
    for ( my $a = 0 ; $a <= $end-3 ; $a ++ )
    {
        for ( my $b = $a+1 ; $b <= $end-2; $b++ )
        {
            for ( my $c = $b + 1 ; $c <= $end-1 ; $c++ )
            {
                my $q = $nums->[$a] + $nums->[$b] + $nums->[$c];
                for ( my $d = $c + 1 ; $d <= $end ; $d++ )
                {
                    if ( $q == $nums->[$d] )
                    {
                        $howMany++;
                        push @quad, [$a, $b, $c, $d] if $Verbose;
                    }
                }
            }
        }
    }
    showQuad(\@quad, $nums) if $Verbose;
    return $howMany;
}

sub showQuad($quad, $nums)
{
    for my $q ( $quad->@* )
    {
        print "nums[", join(", ", $q->@*), "]";
        print "\t";
        print join(", ", $nums->@[$q->@*]);
        print "\n";
    }
}

sub runTest
{
    use Test2::V0;

    is( quad([1,2,3,6  ]), 1, "Example 1");
    is( quad([1,1,1,3,5]), 4, "Example 2");
    is( quad([3,3,6,4,4]), 0, "Example 3");

    done_testing;
}

