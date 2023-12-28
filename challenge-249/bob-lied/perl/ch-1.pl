#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 249 Task 1 Equal Pairs
#=============================================================================
# You are given an array of integers with even number of elements.
# Write a script to divide the given array into equal pairs such that:
# a) Each element belongs to exactly one pair.
# b) The elements present in a pair are equal.
# Example 1 Input: @ints = (3, 2, 3, 2, 2, 2)
#           Output: (2, 2), (3, 3), (2, 2)
# Example 2 Input: @ints = (1, 2, 3, 4)
#           Output: ()
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use List::MoreUtils qw/frequency any/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(", ",
    map { "($_->[0], $_->[1])" } equalPairs(@ARGV)->@*),
    ")";

sub equalPairs(@ints)
{
    return [] if @ints % 2 == 1;

    my %freq = frequency @ints;
    return [] if any { $_ % 2 == 1 } values %freq;

    my @pair;
    while ( %freq )
    {
        for my $n ( sort { $a <=> $b } keys %freq )
        {
            push @pair, [ $n, $n ];
            $freq{$n} -= 2;
            delete $freq{$n} if $freq{$n} == 0;
        }
    }
    return \@pair;
}

sub runTest
{
    use Test2::V0;

    is( equalPairs(3,2,3,2,2,2), [[2,2],[3,3],[2,2]], "Example 1");
    is( equalPairs(1,2,3,4    ), [],                  "Example 2");

    is( equalPairs(6,6,6,6,2,3,2,3,4,3,4,3), [[2,2],[3,3],[4,4],[6,6],[3,3],[6,6]], "More");

    done_testing;
}
