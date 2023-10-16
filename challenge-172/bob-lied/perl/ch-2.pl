#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 172 Task 2 Five-number Summary 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to compute the five-number summary of the given set
# of integers.  You can find the definition and example in the wikipedia page.
# https://en.wikipedia.org/wiki/Five-number_summary
#
# The five-number summary is a set of descriptive statistics that provides
# information about a dataset. It consists of the five most important
# sample percentiles:
#   the sample minimum (smallest observation)
#   the lower quartile or first quartile
#   the median (the middle value)
#   the upper quartile or third quartile
#   the sample maximum (largest observation)
#
# Example 1: Input: @int = (0, 0, 1, 2, 63, 61, 27, 13)
#           Output: 0.00    0.75    7.50   20.88   35.50   63.00
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub fiveNumSum(@int)
{
}

sub runTest
{
    use Test2::V0;

    is(0, 1, "FAIL");

    done_testing;
}

