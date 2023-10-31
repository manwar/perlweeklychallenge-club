#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 240 Task 1 Acronym
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of strings and a check string.
# Write a script to find out if the check string is the acronym of the
# words in the given array.
# Example 1 Input: @str = ("Perl", "Python", "Pascal") $chk = "ppp"
#           Output: true
# Example 2 Input: @str = ("Perl", "Raku") $chk = "rp"
#           Output: false
# Example 3 Input: @str = ("Oracle", "Awk", "C") $chk = "oac"
#           Output: true
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

my $Check = "";

GetOptions("check:s" => \$Check, "test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

die "Usage: $0 -c check stringlist..." unless $Check and @ARGV > 0;

say acronym($Check, @ARGV) ? "true" : "false";

sub acronym($chk, @str)
{
    return $chk eq join("", map { lc substr($_, 0, 1) } @str)
}

sub runTest
{
    use Test2::V0;
    use builtin qw/false true/; no warnings "experimental::builtin";

    is( acronym( "ppp", qw(Perl Python Pascal)), true,  "Example 1");
    is( acronym( "rp" , qw(Perl Raku         )), false, "Example 2");
    is( acronym( "oac", qw(Oracle Awk C      )), true,  "Example 3");

    done_testing;
}
