#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 201 Task 2 Penny Piles
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an integer, $n > 0.
# Write a script to determine the number of ways of putting $n pennies
# in a row of piles of ascending heights from left to right.
# Example Input: $n = 5 Output: 7
#   Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:
#   1 1 1 1 1
#   1 1 1 2
#   1 2 2
#   1 1 3
#   2 3
#   1 4
#   5
#=============================================================================
# This amounts to finding the partitions of a number
# https://en.wikipedia.org/wiki/Partition_(number_theory)
# "No closed-form expression for the partition function is known, but it has
# both asymptotic expansions that accurately approximate it and recurrence
# relations by which it can be calculated exactly."
#
# We will do a recursive expansion and count the results. For each pair of
# possible sums, recurse if the second term is large enough to have sums
# where both terms are bigger than the smaller summand.
# n=7                   n=8
#   1 6                   1 7
#   | 1 5                 | 1 6
#   | | 1 4               | | 1 5
#   | | | 1 3             | | | 1 4
#   | | | | 1 2           | | | | 1 3
#   | | | |   1 1         | | | |   1 2
#   | | | 2 2             | | | |     1 1
#   | | 2 3               | | | | 2 2
#   | 2 4                 | | | 2 3
#   | | 2 2               | | 2 4
#   | 3 3                 | | | 2 2
#   2 5                   | | 3 3
#   | 2 3                 | 2 5
#   3 4                   | | 2 3
#                         | 3 4
#   Total = 15            2 6       Total = 22
#                           2 4
#                             2 2
#                           3 3
#                         3 5
#                         4 4
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say pennyPiles($_) for @ARGV;

sub pennyPiles($n)
{
    # We're accumulating all the possible orderings. We don't
    # really have to do that to get the answer, but it helps debugging.
    my @result = ( [ $n ] );
    say "PUSH [ $n ]" if $Verbose;
    _pile(1, $n-1, [], \@result, "");

    say showResult(\@result) if $Verbose;
    return scalar(@result);
}

sub _pile($p, $q, $soFar, $result, $indent)
{
    say "${indent}[$soFar->@*] _pile($p, $q)," if $Verbose;

    # Take pairs of summands, but only in one order
    while (  $p <= $q )
    {
        say "${indent}PUSH [ $soFar->@* $p $q ]" if $Verbose;
        push @$result, [ $soFar->@*, $p, $q ];

        # If the second term can be split into additions where both
        # terms are greater than p, then recurse to that.
        # For example, (2 6) can split the 6 into 2+4 or 3+3, but not
        # 1+5 because the 1 would violate the ordering rule.
        # For (3 4) we can't split the 4 in a way where both terms
        # are at least 3.
        if ( $q >= 2*$p )
        {
            _pile($p, $q-$p, [ $soFar->@*, $p ], $result, "  $indent");
        }
        $p++; $q--;
    }
}

sub showResult($result)
{
    for my $array ($result->@*) # ( sort { $#{$a} <=> $#{$b} } $result->@* )
    {
        say "[ $array->@* ]";
    }
}

sub runTest
{
    use Test2::V0;

    #is( pennyPiles(1),  1, "Test 1");
    #is( pennyPiles(2),  2, "Test 2");
    #is( pennyPiles(3),  3, "Test 3");
    #is( pennyPiles(4),  5, "Test 4");
    #is( pennyPiles(5),  7, "Example 1");
    is( pennyPiles(6), 11, "Test 6");
    is( pennyPiles(7), 15, "Test 7");
    is( pennyPiles(8), 22, "Test 8");

    done_testing;
}

