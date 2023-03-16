#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 208 Task 2 Duplicate and Missing 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers in sequence with one missing and one
# duplicate.  Write a script to find the duplicate and missing integer in
# the given array. Return -1 if none found.
# For the sake of this task, let us assume the array contains no more than
# one duplicate and missing.
# Example 1: Input: @nums = (1,2,2,4) Output: (2,3)
#   Duplicate is 2 and Missing is 3.
# Example 2: Input: @nums = (1,2,3,4) Output: -1
#   No duplicate and missing found.
# Example 3: Input: @nums = (1,2,3,3) Output: (3,4)
#   Duplicate is 3 and Missing is 4.
#
# There are two ways to interpret this.  One is the way shown in the examples,
# where a single integer in the sequence has been replaced by its neighbor.
#
# Another is that there might be two integers, one of which has a duplicate
# and another that is missing elsewhere in the list, such as 1,2,2,3,4,6.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $retval = dupAndMissing(@ARGV);
say "-1" if @$retval == 0;
say '(', join(',', $retval->@*), ')';


# Find a dup-and-missing where one element of the list has
# been replaced by its neighbor, eg. 1,2,2,4 or 1,2,3,3
# Returns [ dup, missing ], or [] if none found
sub dupAndMissing(@list)
{
    my $current = shift @list;
    while ( my $next = shift @list )
    {
        if ( $next == $current )
        {
            return [ $current, $current+1 ];
        }
        $current = $next;
    }
    return [];
}

# Find a dup and a missing, assuming they might not be
# next to each other, e.g. 1,2,2,3,4,6 or 1,3,4,5,5
sub dupAndMissing_B(@list)
{
    my ($dup, $missing);
    my $current = shift @list;
    while ( my $next = shift @list )
    {
        if ( $current == $next )
        {
            $dup = $current;
        }
        elsif ( $next > $current + 1 )
        {
            $missing = $current + 1;
        }
        $current = $next;
    }
    return [] unless defined $dup && defined $missing;
    return [ $dup, $missing ];
}

sub runTest
{
    use Test2::V0;

    is( dupAndMissing(1,2,2,4), [2,3], "Example 1");
    is( dupAndMissing(1,2,3,4), [   ], "Example 2");
    is( dupAndMissing(1,2,3,3), [3,4], "Example 3");

    is( dupAndMissing(7,8,8,10), [8,9], "Start != 1");
    is( dupAndMissing(7,7,9,10), [7,8], "Start with dup");
    is( dupAndMissing(7,8,8),    [8,9], "Short sequence dup last");
    is( dupAndMissing(7,7,9),    [7,8], "Short sequence dup first");

    is( dupAndMissing(-6,-5,-5,-3), [-5, -4], "Negative sequence");

    is( dupAndMissing_B(1,2,2,3,4,6), [2,5], "Dup before missing");
    is( dupAndMissing_B(1,3,4,5,5,6), [5,2], "Missing before dup");

    done_testing;
}

