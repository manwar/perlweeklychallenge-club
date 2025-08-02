#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 311 Task 1 Upper Lower
#=============================================================================
# You are given a string consists of english letters only.
# Write a script to convert lower case to upper and upper case to lower
# in the given string.
# Example 1 Input: $str = "pERl" Output: "PerL"
# Example 2 Input: $str = "rakU" Output: "RAKu"
# Example 3 Input: $str = "PyThOn" Output: "pYtHoN"
#=============================================================================

use v5.40;

use Getopt::Long;
my $DoTest  = false;

GetOptions("test" => \$DoTest);
#=============================================================================

exit(!runTest()) if $DoTest;

say upperLower($_) for @ARGV;

#=============================================================================
sub upperLower($str)
{
    $str =~ tr/a-zA-Z/A-Za-z/r;
}

sub runTest
{
    use Test2::V0;

    is( upperLower("pERl"),     "PerL", "Example 1");
    is( upperLower("rakU"),     "RAKu", "Example 2");
    is( upperLower("PyThOn"), "pYtHoN", "Example 3");

    done_testing;
}
