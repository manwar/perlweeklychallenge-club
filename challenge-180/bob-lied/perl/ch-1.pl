#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 180 Task 1 First Unique Character
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a string, $s.
# Write a script to find out the first unique character in the given string
# and print its index (0-based).
# Example 1 Input: $s = "Perl Weekly Challenge"
#          Output: 0 as 'P' is the first unique character
# Example 2 Input: $s = "Long Live Perl"
#          Output: 1 as 'o' is the first unique character
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say firstUniq($_) for @ARGV;

sub firstUniq($str)
{
    use List::Util qw/first/;
    use List::MoreUtils qw/frequency/;

    my @s = split '', $str;
    my %f = frequency( @s );

    return first { $f{$s[$_]} == 1 }  0 .. $#s;
}

sub runTest
{
    use Test2::V0;

    is( firstUniq("Perl Weekly Challenge"), 0, "Example 1");
    is( firstUniq("Long Live Perl"),        1, "Example 2");
    is( firstUniq("aaab"),                  3, "Last");
    is( firstUniq("aabb"),              undef, "No unique");
    is( firstUniq("a"),                     0, "Length 1");

    done_testing;
}
