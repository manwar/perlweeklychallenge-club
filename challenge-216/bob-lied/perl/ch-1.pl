#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Task 1 Registration Number 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of words and a random registration number.
# Write a script to find all the words in the given list that has every
# letter in the given registration number.
# Example 1
#   Input: @words = ('abc', 'abcd', 'bcd'), $reg = 'AB1 2CD'
#   Output: ('abcd')
#   The only word that matches every alphabets in the given registration
#   number is 'abcd'.
# Example 2
#   Input: @words = ('job', 'james', 'bjorg'), $reg = '007 JB'
#   Output: ('job', 'bjorg')
# Example 3
#   Input: @words = ('crack', 'road', 'rac'), $reg = 'C7 RA2'
#   Output: ('crack', 'rac')
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub regNumber($num, @words)
{
    (my $mustHave = lc($num)) =~ s/[^a-z]*//g;
    [ grep { $mustHave =~ m/^[$_]+$/ } @words ];
}

sub runTest
{
    use Test2::V0;

    is(regNumber('AB1 2CD', qw(abc abcd bcd)   ), ['abcd'       ], "Example 1");
    is(regNumber('007 JB' , qw(job james bjorg)), ['job','bjorg'], "Example 2");
    is(regNumber('C7 RA2' , qw(crack road rac) ), ['crack','rac'], "Example 3");

    done_testing;
}

