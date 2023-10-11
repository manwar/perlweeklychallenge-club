#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 172 Task 1 Prime Partition 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given two positive integers, $m and $n.
# Write a script to find out the Prime Partition of the given number.
# No duplicates allowed.
# https://en.wikipedia.org/wiki/Partition_(number_theory)
# Example 1: Input: $m = 18, $n = 2
#           Output: 5, 13 or 7, 11
# Example 2: Input: $m = 19, $n = 3
#           Output: 3, 5, 11
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Math::Prime::Util qw/forpart partitions/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub primePartition($m, $n)
{
    my @part;
    forpart { push @part, [ @_ ] } $m, { n => $n, prime => 1 };

    return @part;
}

sub runTest
{
    use Test2::V0;

    is( primePartition(19, 3), [ [3,5,11]       ], "Example 2");
    is( primePartition(18, 2), [ [5,13], [7,11] ], "Example 1");

    done_testing;
}

