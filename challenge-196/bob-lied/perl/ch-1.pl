#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Perl Weekly Challenge Week 196, Challenge 1
#=============================================================================
# Copyright (c) 2022, Bob Lied
#=============================================================================
# You are given a list of integers, @list.
# Write a script to find out subsequence that respect Pattern 132.
# Return empty array if none found.
# Pattern 132 in a sequence (a[i], a[j], a[k])
# such that i < j < k and a[i] < a[k] < a[j].
# Example 1 Input:  @list = (3, 1, 4, 2)
#          Output: (1, 4, 2) respect the Pattern 132.
# Example 2 Input: @list = (1, 2, 3, 4)
#          Output: () since no susbsequence can be found.
# Example 3 Input: @list = (1, 3, 2, 4, 6, 5)
#          Output: (1, 3, 2) more than one subsequence found, return first.
# Example 4 Input: @list = (1, 3, 4, 2)
#          Output: (1, 3, 2)
# 
#=============================================================================

use v5.36;

use List::Util qw/first/;
use List::MoreUtils qw/after_incl/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my @list = @ARGV;
my $answer = find132(\@list);
say "(", join(", ", $answer->@*), ")";
exit 0;

sub is132($list, $i1, $i2, $i3)
{
    return $list->[$i1] < $list->[$i2]
        && $list->[$i1] < $list->[$i3]
        && $list->[$i2] < $list->[$i3];
}

sub find132($list)
{
    return [] if scalar(@$list) < 3;

    while ( my $first = shift @$list )
    {
        my @tail = after_incl { $_ > $first } $list->@*;
        while ( my $middle = shift @tail )
        {
            my $last = first { $_ > $first && $_ < $middle } @tail;
            if ( $last )
            {
                return [ $first, $middle, $last ];
            }
        }
    }
    return [];
}

sub runTest
{
    use Test2::V0;

    is( find132( [ 3,2,1,0     ] ), [     ], "Descending");
    is( find132( [ 1,3,2       ] ), [1,3,2], "Obvious");
    is( find132( [ 3,1,4,2     ] ), [1,4,2], "Example 1");
    is( find132( [ 1,2,3,4     ] ), [     ], "Example 2");
    is( find132( [ 1,3,2,4,6,5 ] ), [1,3,2], "Example 3");
    is( find132( [ 1,3,4,2     ] ), [1,3,2], "Example 4");

    done_testing;
}

