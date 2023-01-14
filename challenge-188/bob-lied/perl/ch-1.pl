#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 188 Task 1 Divisible Pairs
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given list of integers @list of size $n and divisor $k.
# Write a script to find out count of pairs in the given list that satisfies
# the following rules.
#
# The pair (i, j) is eligible if and only if
# a) 0 <= i < j < len(list)
# b) list[i] + list[j] is divisible by k
#
# Example 1 Input: @list = (4, 5, 1, 6), $k = 2 Output: 2
# Example 2 Input: @list = (1, 2, 3, 4), $k = 2 Output: 2
# Example 3 Input: @list = (1, 3, 4, 5), $k = 3 Output: 2
# Example 4 Input: @list = (5, 1, 2, 3), $k = 4 Output: 2
# Example 5 Input: @list = (7, 2, 4, 5), $k = 4 Output: 1
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub divPair($list, $k)
{
    my $n = scalar(@$list);
    my $count = 0;

    for ( my $i = 0 ; $i < ($n-1) ; $i++ )
    {
        for ( my $j = $i + 1 ; $j < $n ; $j++ )
        {
            $count++ if ( ($list->[$i] + $list->[$j]) % $k) == 0;
        }
    }
    return $count;
}

sub divPair2($list, $k)
{
    my $n = scalar(@$list);
    my $count = 0;

    for ( my $i = 0 ; $i < ($n-1) ; $i++ )
    {
        my $x = $list->[$i];
        # Array slice of elements after i
        # map -- perform the arithmetic on each element
        # grep -- choose the ones where remainder is zero
        #   scalar context returns count of matches
        $count += grep { $_ == 0 } map { ( $_ + $x ) % $k } $list->@[$i+1 .. $n-1];
    }
    return $count;
}

sub runTest
{
    use Test2::V0;

    is( divPair( [ 4,5,1,6 ], 2), 2, "Example 1");
    is( divPair( [ 1,2,3,4 ], 2), 2, "Example 2");
    is( divPair( [ 1,3,4,5 ], 3), 2, "Example 3");
    is( divPair( [ 5,1,2,3 ], 4), 2, "Example 4");
    is( divPair( [ 7,2,4,5 ], 4), 1, "Example 5");

    is( divPair2( [ 4,5,1,6 ], 2), 2, "Example 1");
    is( divPair2( [ 1,2,3,4 ], 2), 2, "Example 2");
    is( divPair2( [ 1,3,4,5 ], 3), 2, "Example 3");
    is( divPair2( [ 5,1,2,3 ], 4), 2, "Example 4");
    is( divPair2( [ 7,2,4,5 ], 4), 1, "Example 5");

    done_testing;
}

