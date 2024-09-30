#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 288 Task 1 Closest Palindrome
#=============================================================================
# You are given a string, $str, which is an integer.
# Write a script to find out the closest palindrome, not including itself.
# If there are more than one then return the smallest.
# The closest is defined as the absolute difference minimized between
# two integers.
# Example 1 Input: $str = "123" Output: "121"
# Example 2 Input: $str = "2" Output: "1"
#   There are two closest palindrome "1" and "3".
#   Therefore we return the smallest "1".
# Example 3 Input: $str = "1400" Output: "1441"
# Example 4 Input: $str = "1001" Output: "999"
#=============================================================================

use v5.40;
use List::Util qw/min/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say closest($_) for @ARGV;

sub closest($str)
{
    my $len = length($str);
    return $str-1 if $len == 1;

    my @possible = ( 10**$len + 1, 10**($len-1) - 1 ); # 10*1 and 99*9

    my $leftHalf = substr($str, 0, int(($len + 1)/2));

    for my $left ( $leftHalf-1, $leftHalf, $leftHalf+1 )
    {
        # For even lengths, mirror the left. For odd, don't double middle digit
        my $right = reverse( ($len%2) ? substr($left, 0, length($left)-1) : $left );
        push @possible, "$left$right" unless "$left$right" eq $str;
    }

    # Find the minimum differences
    my $nearest = $possible[0];
    my $min = abs($possible[0] - $str);
    for my $p ( @possible )
    {
        my $diff = abs($p - $str);
        if ( $diff < $min )
        {
            $min = $diff;
            $nearest = $p;
        }
        elsif ( $diff == $min && $p < $nearest )
        {
            $nearest = $p;
        }
    }
    return $nearest;
}

sub brute($str)
{
    my $start = +$str;  # Numeric
    my $delta = 0;

    while ( ++$delta )
    {
        my $p = $start - $delta;
        return $p if "$p" eq reverse("$p");

        $p = $start + $delta;
        return $p if "$p" eq reverse("$p");
    }
}

sub runTest
{
    use Test2::V0;

    is( closest( "123"),  121, "Example 1");
    is( closest(   "2"),    1, "Example 2");
    is( closest("1400"), 1441, "Example 3");
    is( closest("1001"),  999, "Example 4");

    is( closest("146899325"),   146898641, "Big odd-sized number");
    is( closest("1467899325"), 1467887641, "Big even-sized number");
    is( closest("1467809321"), 1467777641, "Big even-sized number");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            reverse => sub { closest("146899325") },
            brute   => sub { brute("146899325") },
        });
}
