#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 073 Task #2 > Smallest Neighbour`
#=============================================================================
#
# You are given an array of integers @A.
# Write a script to create an array that represents the smallest element to the
# left of each corresponding index.  If none found, then use 0.
# Example 1:
# Input: @A = (7,8,3,12,10)
# Output:     (0,7,0, 3, 3)

use strict;
use warnings;
use feature qw(say);

my @A = @ARGV;

sub smallestNeighbor
{
    my ($arr) = @_;
    my @result = (0);   # First result is always zero

    my $smallest = shift(@$arr);
    while ( scalar(@$arr) )
    {
        my $p = shift(@$arr);
        if ( $smallest < $p )
        {
            push @result, $smallest;
        }
        else
        {
            $smallest = $p;
            push @result, 0;
        }
    }

    return @result;
}

say "(", join(",", smallestNeighbor(\@A) ), ")";
