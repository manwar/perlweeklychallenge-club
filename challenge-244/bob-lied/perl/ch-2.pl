#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 244 Task 2  Group Hero
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers representing the strength.
# Write a script to return the sum of the powers of all possible
# combinations; power is defined as the square of the largest number
# in a sequence, multiplied by the smallest.
# Example 1 Input: @nums = (2, 1, 4)
#           Output: 141
#   Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
#   Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
#   Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
#   Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
#   Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
#   Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
#   Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16
# 
#   Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say groupHero(@ARGV);

sub power(@n)
{
    use List::MoreUtils qw/minmax/;

    my ($min, $max);
    if    ( @n == 0 ) { return 0; }
    elsif ( @n == 1 ) { ($min, $max) = ($n[0], $n[0]) }
    else              { ($min, $max) = minmax(@n) }
    return $max * $max * $min;
}

sub groupHero($nums)
{
    use Algorithm::Combinatorics qw/combinations/;

    my $sum = 0;
    for my $k ( 1 .. scalar(@$nums) )
    {
        for my $c ( combinations($nums, $k) )
        {
            $sum += power( $c->@* );
        }
    }
    return $sum;
}

sub runTest
{
    use Test2::V0;

    is( power( ),           0, "Power empty");
    is( power(2),           8, "Power 1 number");
    is( power(5,3),        75, "Power 2 numbers");
    is( power(5,4,3),      75, "Power 3 numbers");
    is( power(9, 5, 7, 1), 81, "Power 4 numbers");

    is( groupHero([2,1,4]), 141, "Example 1");

    done_testing;
}
