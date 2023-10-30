#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 235 Task 1 Remove One 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to find out if removing ONLY one integer makes it
# strictly kincreasing order.
# Example 1 Input: @ints = (0, 2, 9, 4, 6)
#           Output: true
#   Removing ONLY 9 in the given array makes it strictly increasing order.
# Example 2 Input: @ints = (5, 1, 3, 2)
#           Output: false
# Example 3 Input: @ints = (2, 2, 3)
#           Output: true
#=============================================================================

use v5.38;
use builtin qw(true false); no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub removeOne(@ints)
{
    use List::Util qw/min/;

    return true if @ints < 3;

    my $rmvCount = 0;

    # Walk forward until we hit a descending step.
    for ( my $i = 0 ; $i < $#ints && $rmvCount < 2 ; $i++ )
    {
        next if $ints[$i+1] >= $ints[$i];

        # How far backward would we have to go to get back in order?
        my $back = 0;
        for ( my $j = $i ; $j >= 0 && $ints[$j] > $ints[$i+1] && $back < 3; $j-- )
        {
            $back++;
        }
        
        # How far ahead would we have to go to get back in order?
        my $ahead = 0;
        for ( my $j = $i+1; $j <= $#ints && $ints[$j] <= $ints[$i] && $ahead < 3; $j++ )
        {
            $ahead++;
        }
        $rmvCount += min($back, $ahead);

    }
    return $rmvCount < 2;
}

sub runTest
{
    use Test2::V0;
    no warnings "experimental::builtin";

    is( removeOne(0,2,9,4,6), true,  "Example 1");
    is( removeOne(5,1,3,2  ), false, "Example 2");
    is( removeOne(2,2,3    ), true,  "Example 3");
    is( removeOne(10,1,2,3 ), true,  "First element goes");
    is( removeOne(10,11,1  ), true,  "Last element goes");
    is( removeOne(10,20,30,24,25,40), true, "One high peak");
    is( removeOne(10,20,30,18,25,40), false, "One high, one low");
    is( removeOne(1,2,5,3,4,6,3,4),   false, "Multiple disorders");
    is( removeOne(99, 1000, 1..999, 2000), false, "Long failure");

    # is( ro_A(0,2.9,4,6), true,  "Example 1");
    # is( ro_A(5,1,3,2  ), false, "Example 2");
    # is( ro_A(2,2,3    ), true,  "Example 3");

    # is( ro_B(0,2.9,4,6), true,  "Example 1");
    # is( ro_B(5,1,3,2  ), false, "Example 2");
    # is( ro_B(2,2,3    ), true,  "Example 3");

    # is( ro_C(0,2.9,4,6), true,  "Example 1");
    # is( ro_C(5,1,3,2  ), false, "Example 2");
    # is( ro_C(2,2,3    ), true,  "Example 3");

    done_testing;
}

# Things that don't work.

# Move down the list in pairs and count the number of times that
# we find a decreasing pair.  Stop when we hit the second one.
sub ro_D(@ints)
{
    my $rmvCount = 0;
    for ( my $i = 0; $i < $#ints && $rmvCount < 2 ; $i++ )
    {
        $rmvCount++ if $ints[$i+1] < $ints[$i];
    }
    return $rmvCount < 2;
}

# Map each pair to true/false for being sorted ascending.  Count the falses.
# Will be inefficient if the list is long and the out-of-order elements are
# near the front.
sub ro_A(@ints)
{
    my $rmvCount = grep { $_ == false }
                map { $ints[$_] < $ints[$_+1] } 0 .. ( $#ints-1 );
    return $rmvCount < 2;
}

# Slide down the list in pairs and count the number of items that
# are out of order.  Always scans the whole list.
sub ro_B(@ints)
{
    use List::MoreUtils qw/slide/;
    my $rmvCount = 0;
    slide { $rmvCount++ if ( $b < $a ) } @ints;
    return $rmvCount < 2;
}

# Use try/catch to quit early from slide
sub ro_C(@ints)
{
    use List::MoreUtils qw/slide/;
    use feature 'try'; no warnings "experimental::try";
    my $rmvOne = true;
    try {
        my $rmvCount = 0;
        slide { do { die if ++$rmvCount > 1 } if ( $b < $a ) } @ints;
    }
    catch ($e)
    {
        $rmvOne = false;
    }
    return $rmvOne;
}

