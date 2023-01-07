#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Task 1 Twice Largest
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given list of integers, @list.
# Write a script to find out whether the largest item in the list is at least
# twice as large as each of the other items.
# 
# Example 1 Input: @list = (1,2,3,4) Output: -1
#   The largest in the given list is 4.  #   However 4 is not greater than 2*3
# Example 2 Input: @list = (1,2,0,5) Output: 1
#   The largest in the given list is 5. Also 5 is greater than twice of
#   every remaining elements.
# Example 3 Input: @list = (2,6,3,1) Output: 1
#   The largest in the given list is 6. Also 6 is greater than twice of
#   every remaining elements.
# Example 4 Input: @list = (4,5,2,3) Output: -1
#   The largest in the given list is 5. But 5 is less than 2*4 and 2*3
#
# Specification is ambiguous about multiple occurrences of the max.  One
# interpretation is that only one copy of max is taken out of the list for
# comparison, meaning that the duplicate will fail the test.  The other
# interpretation is that all copies of the maximum value are taken out
# of the list before comparison.
#=============================================================================

use v5.36;

use List::Util qw/all/;
use List::MoreUtils qw/after_incl/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

(my $list = "@ARGV") =~ s/[[:punct:]]/ /g;
say twiceLargest( [ split ' ', $list ] );

sub twiceLargest($list)
{
    # Sort to put the max at the front, then shift it off
    my @rest = sort { $b <=> $a } $list->@*;
    my $max = shift @rest;

    # Handle duplicates of max by excluding all max values.
    @rest = after_incl { $_ < $max } @rest;

    return ( all { $max >= 2*$_ } @rest )? 1 : -1;
}

sub runTest
{
    use Test2::V0;

    is( twiceLargest( [1,2,3,4]), -1, "Example 1");
    is( twiceLargest( [1,2,0,5]),  1, "Example 2");
    is( twiceLargest( [2,6,3,1]),  1, "Example 3");
    is( twiceLargest( [4,5,2,3]), -1, "Example 4");
    is( twiceLargest( [8,8,2,3]),  1, "Dup max");

    done_testing;
}

