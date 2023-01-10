#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 199, Task 1 Good Pairs
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of integers, @list.
# Write a script to find the total count of Good Pairs.
# A pair (i, j) is called good if list[i] == list[j] and i < j.
# Example 1 Input: @list = (1,2,3,1,1,3) Output: 4
#   There are 4 good pairs found as below:
#   (0,3) (0,4) (3,4) (2,5)
# Example 2 Input: @list = (1,2,3) Output: 0
# Example 3 Input: @list = (1,1,1,1) Output: 6
#   Good pairs are below:
#   (0,1) (0,2) (0,3) (1,2) (1,3) (2,3)
#=============================================================================

use v5.36;

use List::Util qw/sum/;
use List::MoreUtils qw/frequency/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

(my $lst = "@ARGV") =~ s/[[:punct:]]/ /g;
say goodPairs [ split ' ' $lst ];

# We don't actually have to enumerate the pairs, so let's
# work with just counting the partitiions of equal values.
# Using List::MoreUtils::frequency gives us the count of how
# often each number occurs.
sub goodPairs($list)
{
    my %f = List::MoreUtils::frequency @$list;
    # Eliminate things that have no pairs at all
    my @p = grep { $f{$_} > 1 } keys %f;
    return 0 unless @p;

    # The count of pairs is the combination of N things taken
    # 2 at a time, n!/2*(n-2)! = n*(n-1)/2.
    # Math::Combinatorics has an nCr function, but that's overkill here.
    my $s = sum map { my $n = $f{$_}; $n*($n-1)/2 } @p;
    return $s;
}

sub runTest
{
    use Test2::V0;

    is( goodPairs( [1,2,3,1,1,3] ), 4, "Example 1");
    is( goodPairs( [1,2,3      ] ), 0, "Example 2");
    is( goodPairs( [1,1,1,1    ] ), 6, "Example 2");

    done_testing;
}

