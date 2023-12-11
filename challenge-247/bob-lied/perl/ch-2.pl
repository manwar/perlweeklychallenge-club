#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 247 Task 2 Most Frequent Letter Pair
#=============================================================================
# You are given a string S of lower case letters 'a'..'z'.
# Write a script that finds the pair of consecutive letters in S that
# appears most frequently. If there is more than one such pair, choose
# the one that is the lexicographically first.
# Example 1 Input: $s = 'abcdbca'
#           Output: 'bc'  ('bc' appears twice in `$s`)
# Example 2 Input: $s = 'cdeabeabfcdfabgcd'
#           Output: 'ab'
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub mflp($s)
{
    my %freq;
    $freq{$_}++ for map { substr($s, $_, 2) } 0 .. (length($s)-2);
    return (sort { $freq{$b} <=> $freq{$a} || $a cmp $b } keys %freq)[0];
}

sub runTest
{
    use Test2::V0;

    is( mflp("abcdbca"),           'bc', "Example 1");
    is( mflp("cdeabeabfcdfabgcd"), 'ab', "Example 2");

    done_testing;
}
