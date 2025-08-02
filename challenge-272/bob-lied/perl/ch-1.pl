#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 272 Task 1 Defang IP Address
#=============================================================================
# You are given a valid IPv4 address.
# Write a script to return the defanged version of the given IP address.
# A defanged IP address replaces every period “.” with “[.]".
# Example 1 Input: $ip = "1.1.1.1" Output: "1[.]1[.]1[.]1"
# Example 2 Input: $ip = "255.101.1.0" Output: "255[.]101[.]1[.]0"
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say defangIP($_) for @ARGV;

sub defangIP($ip)
{
    $ip =~ s/\./[.]/gr;
}

sub runTest
{
    use Test2::V0;

    is( defangIP("1.1.1.1"),     "1[.]1[.]1[.]1",     "Example 1");
    is( defangIP("255.101.1.0"), "255[.]101[.]1[.]0", "Example 2");

    done_testing;
}
