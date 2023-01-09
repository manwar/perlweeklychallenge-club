#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge, Week 195, Task 2 Most Frequent Even
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of numbers, @list.
# Write a script to find most frequent even numbers in the list. In case you
# get more than one even number, then return the smallest even integer.
# For all other case, return -1.
# Example 1 Input: @list = (1,1,2,6,2) Output: 2
#   as there are only 2 even numbers 2 and 6 and of those 2 appears the most.
# Example 2 Input: @list = (1,3,5,7) Output: -1
#   since no even numbers found in the list
# Example 3 Input: @list = (6,4,4,6,1) Output: 4
#   since there are only two even numbers 4 and 6. They both appear an equal
#   number of times, so pick the smallest.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Accept any kind of list separated by spaces or punctuation.
# Assume all the numbers are integers.
(my $list = "@ARGV") =~ s/[^0-9]/ /g;

say mostFrequentEven([ split(' ', $list) ]);

sub mostFrequentEven($list)
{
    my %frequency;
    $frequency{$_}++ for grep { $_ % 2 == 0 } $list->@*;

    return -1 if ! keys %frequency;

    # Sort descending by frequency, then ascending by value.
    # Take the first element of the resulting list.
    return (sort { $frequency{$b} <=> $frequency{$a} || $a <=> $b } keys %frequency)[0];
}

sub runTest
{
    use Test2::V0;

    is( mostFrequentEven( [1,1,2,6,2] ),  2, "Example 1");
    is( mostFrequentEven( [1,3,5,7, ] ), -1, "Example 2");
    is( mostFrequentEven( [6,4,4,6,1] ),  4, "Example 3");
    is( mostFrequentEven( [] ), -1, "Empty");
    is( mostFrequentEven( [200] ), 200, "Singleton");
    is( mostFrequentEven( [24,24,24,24] ), 24, "Just one");
    is( mostFrequentEven( [1,20,6,20,1,6,4,4] ), 4, "Threeway");
    is( mostFrequentEven( [1..100, 50, 51] ), 50, "Bigger list");

    done_testing;
}

