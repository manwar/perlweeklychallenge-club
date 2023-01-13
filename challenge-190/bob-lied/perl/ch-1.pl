#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 190 Task 1 Capital Detection
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a string with alphabetic characters only: A..Z and a..z.
# Write a script to find out if the usage of Capital is appropriate if it
# satisfies at least one of the following rules:
# 1) Only first letter is capital and all others are small.
# 2) Every letter is small.
# 3) Every letter is capital.
#
# Example 1 Input: $s = 'Perl' Output: 1
# Example 2 Input: $s = 'TPF' Output: 1
# Example 3 Input: $s = 'PyThon' Output: 0
# Example 4 Input: $s = 'raku' Output: 1
# 
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub capitalDetection($s)
{
    return 1 if $s =~ m/ \A [[:lower:]]+ \z
                       | \A [[:upper:]]+ \z
                       | \A [[:upper:]][[:lower:]]+ \z
                       /x;
    return 0;
}

say capitalDetection($_) for @ARGV;

sub runTest
{
    use Test2::V0;

    is( capitalDetection("Perl"),   1, "Example 1 Perl");
    is( capitalDetection("TPF"),    1, "Example 2 TPF");
    is( capitalDetection("PyThon"), 0, "Example 3 PyThon");
    is( capitalDetection("raku"),   1, "Example 4 raku");

    done_testing;
}

