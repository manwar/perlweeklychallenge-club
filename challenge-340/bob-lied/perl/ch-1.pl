#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 340 Task 1  Duplicate Removals
#=============================================================================
# You are given a string, $str, consisting of lowercase English letters.
# Write a script to return the final string after all duplicate removals
# have been made. Repeat duplicate removals on the given string until we
# no longer can. A duplicate removal consists of choosing two adjacent
# and equal letters and removing them.
#
# Example 1 Input: $str = 'abbaca'
#           Output: 'ca'
#   Step 1: Remove 'bb' => 'aaca'
#   Step 2: Remove 'aa' => 'ca'
# Example 2 Input: $str = 'azxxzy'
#           Output: 'ay'
# Example 3 Input: $str = 'aaaaaaaa'
#           Output: ''
# Example 4 Input: $str = 'aabccba'
#           Output: 'a'
# Example 5 Input: $str = 'abcddcba'
#           Output: ''
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
#=============================================================================

exit(!runTest()) if $DoTest;

say dupRmv($_) for @ARGV;

#=============================================================================
sub dupRmv($str)
{
    while ( $str =~ s/(.)\1//g ) { }
    return $str;
}

sub runTest
{
    use Test2::V0;

    is( dupRmv('abbaca'), 'ca', "Example 1");
    is( dupRmv('azxxzy'), 'ay', "Example 2");
    is( dupRmv('aaaaaaaa'), '', "Example 3");
    is( dupRmv('aabccba'), 'a', "Example 4");
    is( dupRmv('abcddcba'), '', "Example 5");

    done_testing;
}
