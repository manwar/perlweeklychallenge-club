#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 188 Task 2 Total Zero
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given two positive integers $x and $y.
# Write a script to find out the number of operations needed to make both ZERO.
# Each operation is made up either of the followings:
#    $x = $x - $y if $x >= $y
# or
#   $y = $y - $x if $y >= $x (using the original value of $x)
#
# Example 1 Input: $x = 5, $y = 4 Output: 5
# Example 2 Input: $x = 4, $y = 6 Output: 3
# Example 3 Input: $x = 2, $y = 5 Output: 4
# Example 4 Input: $x = 3, $y = 1 Output: 3
# Example 5 Input: $x = 7, $y = 4 Output: 5
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub usage { "Usage: $0 x y   # x and y positive integers" }

my ($x, $y) = @ARGV;
die usage() unless $x > 0 && $y > 0;

say totalZero($x, $y);

sub totalZero($x, $y)
{
    my $count = 0;
    while ( ! ($x == 0 && $y == 0 ) )
    {
        my $x0 = $x;
        if ( $x >= $y )
        {
            $x = $x - $y;
        }
        if ( $y >= $x && $y >= $x0 )
        {
            $y = $y - $x0;
        }
        $count++;
        say "$count: x=$x y=$y" if $Verbose;
    }
    return $count;
}

sub runTest
{
    use Test2::V0;

    is(totalZero(0,0), 0, "Example 0");
    is(totalZero(5,4), 5, "Example 1");
    is(totalZero(4,6), 3, "Example 2");
    is(totalZero(2,5), 4, "Example 3");
    is(totalZero(3,1), 3, "Example 4");
    is(totalZero(7,4), 5, "Example 5");

    done_testing;
}

