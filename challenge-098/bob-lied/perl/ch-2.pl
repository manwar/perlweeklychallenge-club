#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 098 Challenge 2: Search Insert Position
# You are given a sorted array of distinct integers @N and a target $N.
# Write a script to return the index of the given target if found otherwise
# place the target in the sorted array and return the index.
# Example 1:
# Input: @N = (1, 2, 3, 4) and $N = 3
# Output: 2 since the target 3 is in the array at the index 2.
# 
# Example 2:
# Input: @N = (1, 3, 5, 7) and $N = 6
# Output: 3 since the target 6 is missing and should be placed at the index 3.
#=============================================================================

use strict;
use warnings;
use v5.20;

use experimental qw/signatures /;

sub Usage { "Usage: $0 '(n1 ,n2, n3, ...)' N" };

my $n = shift;  # Array in string form
die Usage() unless $n;  # Doesn't allow empty list. Should it?
$n =~ s/[(), ]+/ /g;  # Reduce to list of numbers (assume they're numbers).
my @N = sort { $a <=> $b } split(" ", $n);  # Says sorted, but make it so.
my $N = shift;
die Usage() unless $N;

# Debugging aid
sub show($aref, $left, $mid, $right) { my $p = 0; print "$left $mid $right : ";
    print " $aref->[$p++]  " while ( $p < $left );
    print "[ ";
    print " $aref->[$p++]  " while ( $p < $mid );
    print "($aref->[$mid]) "; $p++;
    print " $aref->[$p++]  " while ( $p <= $right );
    print "] ";
    print "$aref->[$p++] " while ( $p < @$aref );
    print "\n";
}

# Binary search. For really short lists, it would be perfectly
# adequate (maybe better) to do a sequential scan.
sub searchInsertPosition($val, @a)
{
    # say "Looking for $val in [ @a ]";

    my $left = 0;
    my $right = my $end = $#a;
    my $mid;
    while ( $left <= $right )
    {
        $mid = int( ($left + $right) / 2);
        # show(\@a, $left, $mid, $right);
        if ( $a[$mid] == $val )
        {
            last;
        }
        elsif ( $a[$mid] < $val )
        {
            $left = $mid + 1;
        }
        else
        {
            $right = $mid - 1;;
        }
    }

    # Tweak for insert position
    if ( $val <= $a[$mid] )
    {
        return $mid;
    }
    else
    {
        return $mid+1;
    }
    return $mid;
}

say searchInsertPosition($N, @N);
