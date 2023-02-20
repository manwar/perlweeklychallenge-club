#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 176 Task 1 Permuted Multiples
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Write a script to find the smallest positive integer x
# such that x, 2x, 3x, 4x, 5x and 6x are permuted multiples of each other.
# For example, the integers 125874 and 251748 are permutated multiples
# of each other as 251784 = 2 x 125874
# and also both have the same digits but in different order.
# Output 142857
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub runTest
{
    use Test2::V0;

    is(0, 1, "FAIL");

    done_testing;
}

