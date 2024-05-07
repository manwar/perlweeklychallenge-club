#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 267 Task 1 Product Sign
#=============================================================================
# You are given an array of @ints.
# Write a script to find the sign of product of all integers in the given
# array. The sign is 1 if the product is positive, -1 if the product is
# negative and 0 if product is zero.
# Example 1 Input: @ints = (-1, -2, -3, -4, 3, 2, 1)
#           Output: 1
# Example 2 Input: @ints = (1, 2, 0, -2, -1)
#           Output: 0
# Example 3 Input: @ints = (-1, -1, 1, -1, 2)
#           Output: -1
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say prodSign(@ARGV);

sub prodSign(@ints)
{
    my $sign = 1;
    while ( $sign && defined(my $n = shift @ints) )
    {
        $sign *= ($n <=> 0);
    }
    return $sign;
}

sub runTest
{
    use Test2::V0;

    is( prodSign(-1, -2, -3, -4,  3, 2, 1),  1, "Example 1");
    is( prodSign( 1,  2,  0, -2, -1      ),  0, "Example 2");
    is( prodSign(-1, -1,  1, -1,  2      ), -1, "Example 3");

    done_testing;
}
