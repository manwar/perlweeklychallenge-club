#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 202 Task 1 Consecutive Odds
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to print 1 if there are THREE consecutive odds in the given
# array otherwise print 0.
# Example 1 Input: @array = (1,5,3,6) Output: 1
# Example 2 Input: @array = (2,6,3,5) Output: 0
# Example 3 Input: @array = (1,2,3,4) Output: 0
# Example 4 Input: @array = (2,3,5,7) Output: 1
#=============================================================================

use v5.36;

use List::Util qw/all/;
use List::MoreUtils qw/first_index/;

use constant CONSECUTIVE => 3;

use Getopt::Long;
my $DoTest  = 0;
my $Consecutive = CONSECUTIVE;

GetOptions("test" => \$DoTest, "consecutive:i" => \$Consecutive);
exit(!runTest()) if $DoTest;

say consecOdd(\@ARGV, $Consecutive);

sub isOdd($n) { $n % 2 }


sub consecOdd($array, $consec=CONSECUTIVE)
{
    my $i = first_index { isOdd($_) } $array->@*;
    while ( defined $i && $i <= @$array - $consec )
    {
        return 1 if all { isOdd($_) } $array->@[$i .. ($i + $consec - 1)];
        while ( ! isOdd($array->[++$i]) ) {}
    }
    return 0;
}

sub runTest
{
    use Test2::V0;

    is( consecOdd([1,5,3,6]), 1, "Example 1");
    is( consecOdd([2,6,3,5]), 0, "Example 2");
    is( consecOdd([1,2,3,4]), 0, "Example 3");
    is( consecOdd([2,3,5,7]), 1, "Example 4");

    done_testing;
}
