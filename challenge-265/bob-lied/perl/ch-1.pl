#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 265 Task 1 33% Appearance
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to find an integer in the given array that appeared 33%
# or more. If more than one found, return the smallest. If none found then
# return undef.
# Example 1 Input: @ints = (1,2,3,3,3,3,4,2)
#           Output: 3
#   1 appeared 1 times.  2 appeared 2 times.  3 appeared 4 times.
#   3 appeared 50% (>33%) in the given array.
#
# Example 2 Input: @ints = (1,1)
#           Output: 1
#
# Example 3 Input: @ints = (1,2,3)
#           Output: 1
#   1 appeared 1 times.  2 appeared 1 times.  3 appeared 1 times.
#   Since all three appeared 33.3% (>33%) in the given array.
#   We pick the smallest of all.
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say appear33(@ARGV);

sub appear33(@ints)
{
    use List::MoreUtils qw/frequency/;
    use List::Util qw/min/;

    my %f = frequency(@ints);
    return min grep { $f{$_} / $#ints > 0.33 } keys %f;
}

sub runTest
{
    use Test2::V0;

    is( appear33(1,2,3,3,3,3,4,2), 3, "Example 1");
    is( appear33(1,1            ), 1, "Example 2");
    is( appear33(1,2,3          ), 1, "Example 3");

    done_testing;
}
