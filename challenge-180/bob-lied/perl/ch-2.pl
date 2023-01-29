#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 180 Task 2 Trim List
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given list of numbers, @n and an integer $i.
# Write a script to trim the given list where element is less than or equal
# to the given integer.
# Example 1 Input: @n = (1,4,2,3,5) and $i = 3
#          Output: (4,5)
# Example 2 Input: @n = (9,0,6,2,3,8,5) and $i = 4
#          Output: (9,6,8,5)
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

my $i = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "i:i" => \$i);
exit(!runTest()) if $DoTest;

say "(", join(",", trimList( i => $i, n => \@ARGV )->@*), ")";

sub trimList(%arg)
{
    return [ grep { $_ > $arg{i} } $arg{n}->@* ];
}

sub runTest
{
    use Test2::V0;

    is( trimList( n => [1,4,2,3,5],     i => 3 ), [4,5],     "Example 1");
    is( trimList( n => [9,0,6,2,3,8,5], i => 4 ), [9,6,8,5], "Example 2");
    is( trimList( n => [1,4,2,3,5],     i => 6 ), [],        "None");
    is( trimList( n => [1,4,2,3],       i => 0 ), [1,4,2,3], "All");

    done_testing;
}
