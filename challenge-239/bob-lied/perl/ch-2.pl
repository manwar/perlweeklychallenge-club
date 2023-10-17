#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 239 Task 2 Consistent Strings 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of strings and allowed string having distinct
# characters.  A string is consistent if all characters in the string appear
# in the string allowed.
# Write a script to return the number of consistent strings in the given array.
# Example 1 Input: @str = ("ad", "bd", "aaab", "baa", "badab")
#                  $allowed = "ab"
#           Output: 2
#    Strings "aaab" and "baa" are consistent since they only contain
#    characters 'a' and 'b'.
# Example 2 Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
#                  $allowed = "abc"
#           Output: 7
# Example 3 Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
#                  $allowed = "cad"
#           Output: 4
#=============================================================================

use v5.38;

use FindBin qw($Bin);
use lib "$FindBin::Bin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub consistentStrings($allowed, @str)
{
    my $rx = qr/^[$allowed]+$/;

    return scalar grep /$rx/, @str;
}

sub runTest
{
    use Test2::V0;

    is( consistentStrings("ab",  qw(ad bd aaab baa badab")   ), 2, "Example 1");
    is( consistentStrings("abc", qw(a b c ab ac bc abc)      ), 7, "Example 2");
    is( consistentStrings("cad", qw(cc acd b ba bac bad ac d)), 4, "Example 3");

    done_testing;
}

